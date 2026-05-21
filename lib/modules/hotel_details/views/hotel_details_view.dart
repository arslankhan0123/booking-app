import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hotel_details_controller.dart';
import '../../../core/theme/app_colors.dart';

class HotelDetailsView extends GetView<HotelDetailsController> {
  const HotelDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border, color: AppColors.primaryBlue), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share, color: AppColors.primaryBlue), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildGallery(),
                _buildHorizontalAmenities(),
                _buildCheckInfo(),
                _buildPriceSection(),
                _buildTaxiOffer(),
                _buildFacilitiesSection(),
                _buildSurroundingsSection(),
                _buildFoodSection(),
                _buildGeniusStatus(),
                _buildReviewsSection(),
                _buildHouseRulesNotice(),
                _buildPreferredPartner(),
                _buildSurveyCard(),
                _buildFAQs(),
                _buildPropertyOffers(),
                _buildPolicies(),
              ],
            ),
          ),
          _buildStickyFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() => Text(
                  controller.hotelName.value,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(width: 16),
              Obx(() => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF003580),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  controller.rating.value.toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() => Row(
            children: [
              Row(
                children: List.generate(
                  controller.stars.value,
                  (index) => const Icon(Icons.star, color: Colors.orange, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.secondaryYellow, borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.thumb_up, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFF003580), borderRadius: BorderRadius.circular(4)),
                child: const Text('Genius', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          )),
          const SizedBox(height: 12),
          Obx(() => RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.darkGrey, fontSize: 14, height: 1.4),
              children: [
                TextSpan(text: controller.address.value),
                const TextSpan(text: ' • '),
                TextSpan(
                  text: '${controller.ratingText.value}!',
                  style: const TextStyle(color: Color(0xFF008009), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return Obx(() {
      if (controller.galleryImages.isEmpty) {
        return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: _galleryImage(controller.galleryImages[0], height: 200)),
                const SizedBox(width: 2),
                Expanded(
                  flex: 1,
                  child: _galleryImage(
                    controller.galleryImages.length > 1 ? controller.galleryImages[1] : controller.galleryImages[0],
                    height: 200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: _galleryImage(
                    controller.galleryImages.length > 2 ? controller.galleryImages[2] : controller.galleryImages[0],
                    height: 120,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: _galleryImage(
                    controller.galleryImages.length > 3 ? controller.galleryImages[3] : controller.galleryImages[0],
                    height: 120,
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Stack(
                    children: [
                      _galleryImage(
                        controller.galleryImages.length > 4 ? controller.galleryImages[4] : controller.galleryImages[0],
                        height: 120,
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4)),
                        child: const Center(
                          child: Text('+134', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _galleryImage(String url, {required double height}) {
    return Image.network(url, height: height, fit: BoxFit.cover);
  }

  Widget _buildHorizontalAmenities() {
    final list = [
      {'icon': Icons.local_parking_outlined, 'label': 'Free parking'},
      {'icon': Icons.pets_outlined, 'label': 'Pets allowed'},
      {'icon': Icons.ac_unit_outlined, 'label': 'Air conditioning'},
      {'icon': Icons.shower_outlined, 'label': 'Private bathroom'},
      {'icon': Icons.wifi, 'label': 'Free WiFi'},
    ];
    
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'] as IconData, color: Colors.black87, size: 24),
                ),
                const SizedBox(height: 6),
                Text(
                  item['label'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Green discount badges row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF008009), borderRadius: BorderRadius.circular(4)),
                child: const Text('PKR 1,226 off', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF003580), borderRadius: BorderRadius.circular(4)),
                child: const Text('Genius discount', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF008009), borderRadius: BorderRadius.circular(4)),
                child: const Text('Mobile-only price', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price for 1 night, 2 adults', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Obx(() => Text(
                          controller.oldPrice.value,
                          style: const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                          ),
                        )),
                        const SizedBox(width: 8),
                        Obx(() => Text(
                          controller.newPrice.value,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
                        )),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Obx(() {
                      String tax = controller.hotelName.value.contains('Orchard') ? '+PKR 835.92 taxes and charges' : '+PKR 540.00 taxes and charges';
                      return Text(tax, style: const TextStyle(color: AppColors.darkGrey, fontSize: 12));
                    }),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.mediumGrey),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          // No credit card needed box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF5),
              border: Border.all(color: const Color(0xFFD4EED8)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.credit_card_off, color: Color(0xFF008009), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No credit card needed',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All options are bookable without a credit card.',
                        style: TextStyle(color: AppColors.darkGrey, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxiOffer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Book a stay and get a free private taxi from the airport',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Spend over PKR 67,718 at this property and enjoy a free taxi provided by Booking.com.',
                        style: TextStyle(color: AppColors.darkGrey, fontSize: 13, height: 1.3),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: const Text('Learn more', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close, size: 20, color: AppColors.darkGrey),
                    ),
                    const SizedBox(height: 10),
                    const Icon(Icons.local_taxi, size: 60, color: Colors.orange), // Simulated taxi image
                    const Text('Booking.com', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilitiesSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Great for your stay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildFacilityGrid(),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text('Show all 107 facilities', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 40, color: AppColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildFacilityGrid() {
    final facilities = [
      {'icon': Icons.restaurant, 'label': 'Restaurant'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.shower_outlined, 'label': 'Private bathroom'},
      {'icon': Icons.spa_outlined, 'label': 'Spa and wellness centre'},
      {'icon': Icons.ac_unit, 'label': 'Air conditioning'},
      {'icon': Icons.wifi, 'label': 'Free WiFi'},
      {'icon': Icons.directions_bus_outlined, 'label': 'Shuttle service'},
      {'icon': Icons.bathtub_outlined, 'label': 'Bath'},
      {'icon': Icons.fitness_center, 'label': 'Fitness centre'},
      {'icon': Icons.tv, 'label': 'Flat-screen TV'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: facilities.map((f) => SizedBox(
        width: (Get.width - 64) / 2.2,
        child: Row(
          children: [
            Icon(f['icon'] as IconData, size: 20, color: Colors.black87),
            const SizedBox(width: 8),
            Expanded(child: Text(f['label'] as String, style: const TextStyle(fontSize: 14))),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSurroundingsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Property surroundings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://miro.medium.com/v2/resize:fit:1400/1*qYU8vlSAs97D9vN_99mD0w.png', // Simulated map placeholder
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Near Mall of the Emirates, Al Barsha, 8088 , Al Barsha, Dubai, United Arab Emirates • 7.2 miles from centre • Fabulous location!',
            style: TextStyle(color: AppColors.darkGrey, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 24),
          _buildSurroundingsTabs(),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          _buildAttractionCategory(Icons.local_play_outlined, 'Top attractions'),
          _buildNearbyItem('Lahore Museum', '14 min (14 km)', Icons.directions_car_outlined),
          _buildNearbyItem('Allama Iqbal Museum', '15 min (15 km)', Icons.directions_car_outlined),
          _buildNearbyItem('Army Museum Lahore', '16 min (17 km)', Icons.directions_car_outlined),
          const SizedBox(height: 24),
          _buildAttractionCategory(Icons.directions_walk, 'What\'s nearby'),
          _buildNearbyItem('Chauburji', '12 min (12 km)', Icons.directions_car_outlined),
          _buildNearbyItem('Jilani Park', '12 min (12 km)', Icons.directions_car_outlined),
          _buildNearbyItem('Bagh-e-Jinnah', '13 min (12 km)', Icons.directions_car_outlined),
          const SizedBox(height: 16),
          const Text(
            'Walking and driving times are based on the fastest route from the property. When no route is available, distances are shown measured in a straight line. Actual travel times and distances may vary.',
            style: TextStyle(color: AppColors.mediumGrey, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSurroundingsTabs() {
    return Row(
      children: [
        _buildTab('Attractions', true),
        _buildTab('Eat and drink', false),
        _buildTab('Transport', false),
      ],
    );
  }

  Widget _buildTab(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: active ? const Color(0xFF006CE4) : Colors.transparent, width: 2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? const Color(0xFF006CE4) : AppColors.darkGrey,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildAttractionCategory(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildNearbyItem(String name, String distance, IconData travelIcon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
          Row(
            children: [
              Icon(travelIcon, size: 16, color: AppColors.darkGrey),
              const SizedBox(width: 4),
              Text(distance, style: const TextStyle(fontSize: 13, color: AppColors.darkGrey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Food & drink', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'Find out what food and drink options you could be enjoying at this property',
            style: TextStyle(color: AppColors.darkGrey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text('See all food details', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 40, color: AppColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildGeniusStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('You\'re at Genius Level 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Available on select options:', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.secondaryYellow, size: 22),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('12% discount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('Applied to the price before taxes and charges', style: TextStyle(color: AppColors.mediumGrey, fontSize: 12)),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: AppColors.lightGrey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Booking.com\'s loyalty programme', style: TextStyle(color: AppColors.mediumGrey, fontSize: 12)),
                const Text('Genius', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Guest reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Obx(() => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF003580), borderRadius: BorderRadius.circular(4)),
                child: Text(controller.rating.value.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              )),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.ratingText.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  Obx(() => Text('See all ${controller.reviewsCount.value} reviews', style: const TextStyle(color: AppColors.darkGrey, fontSize: 12))),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          _buildReviewCriteria('Cleanliness', 8.9, AppColors.primaryBlue),
          _buildReviewCriteria('Comfort', 8.6, AppColors.primaryBlue),
          _buildReviewCriteriaWithArrow('Facilities', 9.3, const Color(0xFF008009), 'High score for Lahore'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Show more', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF006CE4), size: 18),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Guests who stayed here loved', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Color(0xFF2E6515), shape: BoxShape.circle),
                child: const Center(child: Text('Y', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Yasir – Solo traveller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 8,
                        color: const Color(0xFF006600),
                        child: const Center(child: Icon(Icons.star, color: Colors.white, size: 6)),
                      ),
                      const SizedBox(width: 4),
                      const Text('Pakistan', style: TextStyle(color: AppColors.darkGrey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '"very good Hotel very good stop very clean very big rooms looking in five star"',
            style: TextStyle(color: Colors.black87, fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCriteria(String label, double score, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text(score.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: score / 10,
              backgroundColor: AppColors.lightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCriteriaWithArrow(String label, double score, Color color, String subText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(label, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_upward, color: Color(0xFF008009), size: 14),
                ],
              ),
              Text(score.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: score / 10,
              backgroundColor: AppColors.lightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_upward, color: Color(0xFF008009), size: 16),
              const SizedBox(width: 4),
              Text(subText, style: const TextStyle(color: AppColors.darkGrey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check-in', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('Thu 21 May', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF006CE4))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check-out', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('Fri 22 May', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF006CE4))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Rooms and guests', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
          const SizedBox(height: 4),
          const Text('1 room, 2 adults, 0 children', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF006CE4))),
        ],
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: const Text('Select rooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
  Widget _buildHouseRulesNotice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('This property will not accommodate hen, stag or similar parties.', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          const Text('Read more', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
          const SizedBox(height: 16),
          const Divider(color: AppColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildPreferredPartner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Preferred Partner Programme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          const Text(
            'This property is part of our Preferred Partner Programme. It is committed to providing commendable service and good value. It will pay us a higher commission if you make a booking.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildSurveyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('How are we doing?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Icon(Icons.close, color: AppColors.darkGrey),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(color: Color(0xFFE6F0FA), shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(Icons.person, color: Color(0xFF006CE4), size: 40),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1 of 2', style: TextStyle(color: AppColors.darkGrey, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('It is easy to compare accommodation options', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildRadioOption('Strongly agree'),
            _buildRadioOption('Agree'),
            _buildRadioOption('Neutral'),
            _buildRadioOption('Disagree'),
            _buildRadioOption('Strongly disagree'),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.mediumGrey),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFAQs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          _buildFAQItem('How and when do I pay?'),
          const Divider(color: AppColors.lightGrey),
          _buildFAQItem('Are there rooms with a balcony?'),
          const Divider(color: AppColors.lightGrey),
          _buildFAQItem('Are there rooms with a hot tub?'),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF006CE4)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline, color: Color(0xFF006CE4), size: 20),
                SizedBox(width: 8),
                Text('Ask a question', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Instant answer to most questions', style: TextStyle(color: AppColors.darkGrey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.darkGrey),
          const SizedBox(width: 12),
          Expanded(child: Text(question, style: const TextStyle(fontSize: 14))),
          const Icon(Icons.chevron_right, color: AppColors.darkGrey),
        ],
      ),
    );
  }

  Widget _buildPropertyOffers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('What this property offers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 14, height: 1.5),
              children: [
                TextSpan(text: 'Comfortable Accommodations: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Hotel Grand Orchard in Lahore offers family rooms with air-conditioning, private bathrooms, and free WiFi. Each room includes a dining table, work desk, and TV, ensuring a pleasant stay.\n...'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Read more', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
          const SizedBox(height: 24),
          const Divider(color: AppColors.lightGrey),
        ],
      ),
    );
  }

  Widget _buildPolicies() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Policies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          const Text('Check-in: from 12:00 pm until 12:00 am\nCheck-out: from 12:00 pm until 12:00 pm', style: TextStyle(fontSize: 14, height: 1.5)),
          const SizedBox(height: 16),
          const Text('No booking or credit card fees', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 24),
          const Text('See policies of the property', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
        ],
      ),
    );
  }
}
