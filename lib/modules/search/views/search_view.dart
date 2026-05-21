import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../core/theme/app_colors.dart';

class SearchView extends GetView<SearchScreenController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking.com'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search), // Added magnifying glass
            onPressed: () => Get.toNamed('/destination-search'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category selector + overlapping Search Card
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Blue background banner extending downwards
                Container(
                  color: AppColors.primaryBlue,
                  height: 90, // category selector height (54) + 36px overlap region
                ),
                // Column that has the Category selector + Search Card
                Column(
                  children: [
                    // Category horizontal list
                    Container(
                      height: 54,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemBuilder: (context, index) {
                          final cat = controller.categories[index];
                          return Obx(() => GestureDetector(
                                onTap: () => controller.selectedCategory.value = index,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: controller.selectedCategory.value == index
                                        ? Colors.white.withOpacity(0.12)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: controller.selectedCategory.value == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconData(cat['icon'] as int,
                                            fontFamily: 'MaterialIcons'),
                                        color: Colors.white,
                                        size: 18, // Reduced from 22
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        cat['name'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    const SizedBox(height: 8), // spacing before the card
                    // DYNAMIC Search Card
                    Obx(() => _buildDynamicSearchCard()),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // DYNAMIC Body Content
            Obx(() => _buildCategoryBody()),

            const SizedBox(height: 16),
            
            // Footer recommendations
            _buildPersonalizedFooter(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicSearchCard() {
    int index = controller.selectedCategory.value;
    if (index == 0) {
      return _buildStaysSearchCard();
    } else if (index == 1) {
      return _buildCarRentalSearchCard();
    } else if (index == 2) {
      return _buildTaxiSearchCard();
    } else {
      return _buildAttractionsSearchCard();
    }
  }

  Widget _buildStaysSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildSearchItem(
                Icons.search,
                controller.searchText.value,
                onTap: () => Get.toNamed('/destination-search'),
              ),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),
              _buildSearchItem(
                Icons.calendar_today_outlined,
                'Fri 15 May - Sat 16 May',
                onTap: () => _showDateSelection('stays'),
              ),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),
              _buildSearchItem(
                Icons.person_outline,
                '1 room · 2 adults · 0 children',
                onTap: () => _showPassengerSelection(isStays: true),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/search-results'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarRentalSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Row 1: Return to same location
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Return to same location',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Obx(() => Switch(
                      value: controller.carReturnSameLocation.value,
                      onChanged: (val) {
                        controller.carReturnSameLocation.value = val;
                      },
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.accentBlue,
                      inactiveThumbColor: Colors.grey[300],
                      inactiveTrackColor: Colors.grey[400],
                    )),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 2: Pick-up location
              Obx(() => _buildSearchItem(
                Icons.directions_car_outlined,
                controller.carPickUpLocation.value,
                onTap: () => _showLocationSelection('car_pickup'),
              )),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 3: Pick-up date range
              Obx(() => _buildSearchItem(
                Icons.calendar_today_outlined,
                controller.carDates.value,
                onTap: () => _showDateSelection('car_dates'),
              )),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 4: Driver's age
              Obx(() => _buildSearchItem(
                Icons.person_outline,
                controller.carDriverAge.value,
                onTap: () => _showDriverAgeSelection(),
              )),
              
              // Button: Search
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Car Rental Search',
                      'Searching for rental cars in ${controller.carPickUpLocation.value}...',
                      backgroundColor: AppColors.primaryBlue,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaxiSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Row 1: Trip type radio buttons (One-way / Round-trip)
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.taxiTripType.value = 'one-way',
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Icon(
                            controller.taxiTripType.value == 'one-way'
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: AppColors.accentBlue,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'One-way',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () => controller.taxiTripType.value = 'round-trip',
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Icon(
                            controller.taxiTripType.value == 'round-trip'
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: controller.taxiTripType.value == 'round-trip'
                                ? AppColors.accentBlue
                                : AppColors.mediumGrey,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Round-trip',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 2: custom dual pick-up/destination fields
              _buildTaxiLocationsWidget(),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 3: Pick-up time
              Obx(() => _buildSearchItem(
                Icons.calendar_today_outlined,
                controller.taxiPickUpTime.value,
                onTap: () => _showTimeSelection(),
              )),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),

              // Row 4: Passengers
              Obx(() => _buildSearchItem(
                Icons.person_outline,
                controller.taxiPassengersCount.value,
                onTap: () => _showPassengerSelection(isStays: false),
              )),

              // Button: Check prices
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Taxi Search',
                      'Checking prices from ${controller.taxiPickUpLocation.value} to ${controller.taxiDestination.value}...',
                      backgroundColor: AppColors.primaryBlue,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Check prices',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaxiLocationsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Left side vertical line connector
          Column(
            children: [
              const Icon(Icons.location_on_outlined, color: AppColors.mediumGrey, size: 22),
              Container(
                width: 1.5,
                height: 24,
                color: AppColors.mediumGrey.withOpacity(0.5),
              ),
              const Icon(Icons.location_on_outlined, color: AppColors.mediumGrey, size: 22),
            ],
          ),
          const SizedBox(width: 12),
          // Middle fields
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _showLocationSelection('taxi_pickup'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Obx(() => Text(
                      controller.taxiPickUpLocation.value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: controller.taxiPickUpLocation.value.contains('Enter')
                            ? AppColors.mediumGrey
                            : AppColors.darkGrey,
                      ),
                    )),
                  ),
                ),
                const Divider(height: 1, color: AppColors.lightGrey, thickness: 1),
                InkWell(
                  onTap: () => _showLocationSelection('taxi_destination'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Obx(() => Text(
                      controller.taxiDestination.value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: controller.taxiDestination.value.contains('Enter')
                            ? AppColors.mediumGrey
                            : AppColors.darkGrey,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Swap icon
          IconButton(
            icon: const Icon(Icons.swap_vert, color: AppColors.accentBlue, size: 24),
            onPressed: () {
              final temp = controller.taxiPickUpLocation.value;
              controller.taxiPickUpLocation.value = controller.taxiDestination.value;
              controller.taxiDestination.value = temp;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttractionsSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildSearchItem(
                Icons.search,
                'Where are you going?',
                onTap: () => Get.toNamed('/destination-search'),
              ),
              const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),
              _buildSearchItem(
                Icons.calendar_today_outlined,
                'Any dates',
                onTap: () => _showDateSelection('attractions'),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Attractions Search',
                      'Searching for experiences and tours...',
                      backgroundColor: AppColors.primaryBlue,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBody() {
    int index = controller.selectedCategory.value;
    if (index == 0) return _buildStaysBody();
    if (index == 1) return _buildCarsBody();
    return _buildCommonBody();
  }

  Widget _buildStaysBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGeniusBanner(),
        const SizedBox(height: 24),
        _buildContinueSearch(),
        const SizedBox(height: 24),
        _buildSectionHeader('Last-minute ideas'),
        _buildLastMinuteIdeas(),
        const SizedBox(height: 24),
        _buildSectionHeader('Need ideas?'),
        _buildCityList(),
        const SizedBox(height: 24),
        _buildSectionHeader('Deals for the weekend'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Save on stays for 22 May - 24 May', style: TextStyle(color: AppColors.mediumGrey)),
        ),
        _buildDealsList(),
        const SizedBox(height: 24),
        _buildSectionHeader('Offers'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Promotions, deals and special offers for you', style: TextStyle(color: AppColors.mediumGrey)),
        ),
        _buildOfferCard(),
      ],
    );
  }

  Widget _buildCarsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Popular car hire brands'),
        _buildBrandsGrid(),
        const SizedBox(height: 24),
        _buildInfoCards(),
        const SizedBox(height: 24),
        _buildGeniusBanner(),
      ],
    );
  }

  Widget _buildCommonBody() {
    return Column(
      children: [
        _buildGeniusBanner(),
        const SizedBox(height: 24),
        _buildContinueSearch(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCityList() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: controller.cities.length,
        itemBuilder: (context, index) {
          final city = controller.cities[index];
          return GestureDetector(
            onTap: () {
              if (city['name'] == 'Dubai') {
                Get.toNamed('/attractions');
              } else {
                controller.searchText.value = city['name']!;
                Get.toNamed('/search-results');
              }
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.lightGrey,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        city['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      city['name']!,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 10)]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDealsList() {
    return SizedBox(
      height: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, top: 12),
        itemCount: controller.weekendDeals.length,
        itemBuilder: (context, index) {
          final deal = controller.weekendDeals[index];
          return GestureDetector(
            onTap: () {
              controller.searchText.value = deal['name']!;
              Get.toNamed('/search-results');
            },
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Center(child: Icon(Icons.hotel, size: 50, color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deal['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                            child: Text(deal['rating']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          Text(deal['reviewText']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(' · ${deal['reviews']} reviews', style: const TextStyle(color: AppColors.mediumGrey, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.mediumGrey),
                          Text(deal['location']!, style: const TextStyle(color: AppColors.mediumGrey)),
                        ],
                      ),
                      if (index == 1)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
                          child: const Text('Mobile-only price', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(deal['nights']!, style: const TextStyle(fontSize: 12, color: AppColors.mediumGrey)),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(deal['oldPrice']!, style: const TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough)),
                                const SizedBox(width: 4),
                                Text(deal['newPrice']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          );
        },
      ),
    );
  }

  Widget _buildOfferCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("It's time to get away", style: TextStyle(color: AppColors.darkGrey)),
                        const SizedBox(height: 4),
                        const Text('Book a Getaway Deal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 12),
                        const Text('Lock in at least 15% off select stays for your next trip.', style: TextStyle(color: AppColors.darkGrey)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Get.toNamed('/getaway-deals'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentBlue, foregroundColor: Colors.white),
                          child: const Text('Save on your next trip'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.beach_access, color: Colors.orange, size: 50),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.carBrands.length,
        itemBuilder: (context, index) {
          return _buildBrandLogoCard(controller.carBrands[index]);
        },
      ),
    );
  }

  Widget _buildBrandLogoCard(String brand) {
    Color bgColor = Colors.white;
    Border? border = Border.all(color: AppColors.lightGrey);
    Widget child = Text(
      brand,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
    );

    switch (brand.toLowerCase()) {
      case 'alamo':
        bgColor = const Color(0xFF003D7A); // Alamo Blue
        border = Border.all(color: const Color(0xFFF1C40F), width: 1.5); // Alamo Yellow border
        child = const Text(
          'Alamo',
          style: TextStyle(color: Color(0xFFF1C40F), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
        );
        break;
      case 'avis':
        bgColor = Colors.white;
        border = Border.all(color: AppColors.lightGrey);
        child = const Text(
          'AVIS',
          style: TextStyle(color: Color(0xFFED1C24), fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic),
        );
        break;
      case 'budget':
        bgColor = Colors.white;
        border = Border.all(color: AppColors.lightGrey);
        child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              color: Colors.orange,
            ),
            const SizedBox(width: 3),
            const Text(
              'Budget',
              style: TextStyle(color: Color(0xFF002F6C), fontWeight: FontWeight.w900, fontSize: 11),
            ),
          ],
        );
        break;
      case 'dollar.':
        bgColor = const Color(0xFFE31B23); // Dollar Red
        border = null;
        child = const Text(
          'dollar.',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        );
        break;
      case 'enterprise':
        bgColor = const Color(0xFF0F3E28); // Enterprise Green
        border = null;
        child = const Text(
          'enterprise',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: -0.2),
        );
        break;
      case 'europcar':
        bgColor = const Color(0xFF00A651); // Europcar green
        border = null;
        child = const Text(
          'Europcar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11),
        );
        break;
      case 'green motion':
        bgColor = Colors.black;
        border = Border.all(color: const Color(0xFF8DC63F), width: 1.2);
        child = const Text(
          'green\nmotion',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF8DC63F), fontWeight: FontWeight.w800, fontSize: 8, height: 1.0),
        );
        break;
      case 'hertz':
        bgColor = Colors.white;
        border = Border.all(color: Colors.black);
        child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color(0xFFFFD100),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              child: const Text(
                'Hertz',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
          ],
        );
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 3,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Center(child: child),
    );
  }

  Widget _buildInfoCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F7FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accentBlue.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "We're here for you",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.darkGrey),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Customer support in over 30 languages",
                        style: TextStyle(fontSize: 12, color: AppColors.mediumGrey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.support_agent, color: AppColors.accentBlue, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F7FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accentBlue.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Free cancellation",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.darkGrey),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Up to 48 hours before pick-up, on most bookings",
                        style: TextStyle(fontSize: 12, color: AppColors.mediumGrey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.event_available, color: Colors.green, size: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeniusBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Travel more, spend less', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed('/genius'),
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Genius', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                        SizedBox(height: 4),
                        Text('گجر, you\'re at Genius Level 1 in our loyalty programme', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => Get.toNamed('/genius'),
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.lightGrey)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('10% discounts on stays', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 8),
                        Text('Enjoy discounts at participating properties worldwide', style: TextStyle(color: AppColors.darkGrey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContinueSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Continue your search', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            itemCount: controller.continueSearches.length,
            itemBuilder: (context, index) {
              final item = controller.continueSearches[index];
              return GestureDetector(
                onTap: () {
                  controller.searchText.value = item['title']!;
                  Get.toNamed('/search-results');
                },
                child: Container(
                  width: 290,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 70,
                          height: 70,
                          color: AppColors.lightGrey,
                          child: item['imageUrl'] != null
                              ? Image.network(
                                  item['imageUrl']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.hotel, color: Colors.grey),
                                )
                              : const Icon(Icons.hotel, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle']!,
                              style: const TextStyle(fontSize: 12, color: AppColors.mediumGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLastMinuteIdeas() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: controller.lastMinuteDeals.length,
        itemBuilder: (context, index) {
          final deal = controller.lastMinuteDeals[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/hotel-details', arguments: deal);
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      deal['imageUrl']!,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 140,
                        color: AppColors.lightGrey,
                        child: const Icon(Icons.hotel, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          deal['distance']!,
                          style: const TextStyle(fontSize: 12, color: AppColors.mediumGrey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              deal['oldPrice']!,
                              style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              deal['newPrice']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPersonalizedFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.orange),
            const SizedBox(width: 12),
            const Expanded(child: Text('Manage personalized recommendations')),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchItem(IconData icon, String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.darkGrey, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Interactive Bottom Sheets
  void _showLocationSelection(String type) {
    final query = ''.obs;
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        height: Get.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type.contains('pickup') ? 'Select Pick-up Location' : 'Select Destination',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (val) => query.value = val,
              decoration: InputDecoration(
                hintText: 'Search locations...',
                prefixIcon: const Icon(Icons.search, color: AppColors.mediumGrey),
                filled: true,
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Popular destinations',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.mediumGrey),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                final popular = [
                  'Lahore, Pakistan',
                  'Islamabad, Pakistan',
                  'Karachi, Pakistan',
                  'Dubai, United Arab Emirates',
                  'Heathrow Airport (LHR), London'
                ];
                final filtered = popular
                    .where((loc) => loc.toLowerCase().contains(query.value.toLowerCase()))
                    .toList();
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.accentBlue),
                      title: Text(filtered[index]),
                      onTap: () {
                        if (type == 'car_pickup') {
                          controller.carPickUpLocation.value = filtered[index];
                        } else if (type == 'taxi_pickup') {
                          controller.taxiPickUpLocation.value = filtered[index];
                        } else if (type == 'taxi_destination') {
                          controller.taxiDestination.value = filtered[index];
                        }
                        Get.back();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDateSelection(String type) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Dates',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: AppColors.accentBlue),
              title: const Text('22 May, 10:00 am - 25 May, 10:00 am'),
              subtitle: const Text('Friday to Monday, 3 days rental'),
              onTap: () {
                if (type == 'car_dates') {
                  controller.carDates.value = '22 May, 10:00 am - 25 May, 10:00 am';
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: AppColors.accentBlue),
              title: const Text('10 June, 10:00 am - 17 June, 10:00 am'),
              subtitle: const Text('Wednesday to Wednesday, 7 days rental'),
              onTap: () {
                if (type == 'car_dates') {
                  controller.carDates.value = '10 Jun, 10:00 am - 17 Jun, 10:00 am';
                }
                Get.back();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showDriverAgeSelection() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Driver\'s Age',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Car rental companies may charge more or have restrictions for drivers under 30 or over 65.',
              style: TextStyle(color: AppColors.mediumGrey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('30 - 65 years old (Recommended)'),
              leading: const Icon(Icons.check_circle, color: AppColors.accentBlue),
              onTap: () {
                controller.carDriverAge.value = 'Driver\'s age: 30-65';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('18 - 29 years old'),
              leading: const Icon(Icons.circle_outlined, color: AppColors.mediumGrey),
              onTap: () {
                controller.carDriverAge.value = 'Driver\'s age: 18-29';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('66+ years old'),
              leading: const Icon(Icons.circle_outlined, color: AppColors.mediumGrey),
              onTap: () {
                controller.carDriverAge.value = 'Driver\'s age: 66+';
                Get.back();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showTimeSelection() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pick-up Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.access_time, color: AppColors.accentBlue),
              title: const Text('Right now / As soon as possible'),
              onTap: () {
                controller.taxiPickUpTime.value = 'As soon as possible';
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time, color: AppColors.accentBlue),
              title: const Text('Today at 02:00 PM'),
              onTap: () {
                controller.taxiPickUpTime.value = 'Today, 2:00 PM';
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time, color: AppColors.accentBlue),
              title: const Text('Tomorrow at 10:00 AM'),
              onTap: () {
                controller.taxiPickUpTime.value = 'Tomorrow, 10:00 AM';
                Get.back();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showPassengerSelection({required bool isStays}) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isStays ? 'Select Rooms & Guests' : 'Select Passengers',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.accentBlue),
              title: const Text('2 Passengers / Guests'),
              subtitle: const Text('Standard group'),
              onTap: () {
                if (!isStays) {
                  controller.taxiPassengersCount.value = '2 passengers';
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group, color: AppColors.accentBlue),
              title: const Text('4 Passengers / Guests'),
              subtitle: const Text('Large group / SUV recommended'),
              onTap: () {
                if (!isStays) {
                  controller.taxiPassengersCount.value = '4 passengers';
                }
                Get.back();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
