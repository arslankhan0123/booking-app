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
            // Category horizontal list
            Container(
              color: AppColors.primaryBlue,
              height: 54, // Reduced from 60
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
            
            const SizedBox(height: 16),
            
            // DYNAMIC Search Card
            Obx(() => _buildDynamicSearchCard()),
            
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
    List<Widget> fields = [];
    String buttonText = 'Search';

    if (index == 0) { // Stays
      fields = [
        _buildSearchItem(
          Icons.search,
          controller.searchText.value,
          onTap: () => Get.toNamed('/destination-search'),
        ),
        _buildSearchItem(Icons.calendar_today_outlined, 'Fri 15 May - Sat 16 May'),
        _buildSearchItem(Icons.person_outline, '1 room · 2 adults · 0 children'),
      ];
    } else if (index == 1) { // Car rental
      fields = [
        _buildSearchItem(
          Icons.directions_car_outlined,
          'Pick-up location',
          onTap: () => Get.toNamed('/destination-search'),
        ),
        _buildSearchItem(Icons.calendar_today_outlined, 'Pick-up date'),
        _buildSearchItem(Icons.person_outline, "Driver's age: 30-65"),
      ];
    } else if (index == 2) { // Taxi
      fields = [
        _buildSearchItem(
          Icons.location_on_outlined,
          'Enter destination',
          onTap: () => Get.toNamed('/destination-search'),
        ),
        _buildSearchItem(Icons.calendar_today_outlined, 'Choose your pick-up time'),
        _buildSearchItem(Icons.person_outline, '2 passengers'),
      ];
      buttonText = 'Check prices';
    } else { // Attractions
      fields = [
        _buildSearchItem(
          Icons.search,
          'Where are you going?',
          onTap: () => Get.toNamed('/destination-search'),
        ),
        _buildSearchItem(Icons.calendar_today_outlined, 'Any dates'),
      ];
    }

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
              ...fields.map((f) => Column(
                children: [
                  f,
                  if (fields.indexOf(f) != fields.length - 1)
                    const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1.5),
                ],
              )),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/search-results'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  const Positioned.fill(
                    child: Icon(Icons.image, size: 50, color: Colors.grey), // Placeholder
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
          return Container(
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
                      if (index == 1) // Mobile only price tag for the second one
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
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                controller.carBrands[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: _buildSimpleInfoCard(Icons.headset_mic_outlined, "We're here for you", "Customer support in over 30 languages"),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSimpleInfoCard(Icons.calendar_today_outlined, "Free cancellation", "Up to 48 hours before pick-up"),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSimpleInfoCard(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F7FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.orange, size: 30),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(sub, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey)),
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
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed('/hotel-details'),
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    children: [
                      Container(width: 60, height: 60, color: AppColors.lightGrey, child: const Icon(Icons.hotel)),
                      const SizedBox(width: 12),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Avari Xpress Gulberg', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('19 - 20 Jan, 2 adults', style: TextStyle(fontSize: 12, color: AppColors.mediumGrey)),
                        ],
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
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
