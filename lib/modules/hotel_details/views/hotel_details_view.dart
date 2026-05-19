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
                _buildCheckInfo(),
                _buildPriceSection(),
                _buildTaxiOffer(),
                _buildFacilitiesSection(),
                _buildSurroundingsSection(),
                _buildFoodSection(),
                _buildGeniusStatus(),
                _buildReviewsSection(),
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
                child: Text(
                  controller.hotelName.value,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF003580),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  controller.rating.value.toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(children: List.generate(4, (index) => const Icon(Icons.star, color: Colors.orange, size: 20))),
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
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.darkGrey, fontSize: 14, height: 1.4),
              children: [
                TextSpan(text: controller.address.value),
                const TextSpan(text: ' • '),
                const TextSpan(text: 'Fabulous location!', style: TextStyle(color: Color(0xFF008009), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: _galleryImage(controller.galleryImages[0], height: 200)),
              const SizedBox(width: 2),
              Expanded(flex: 1, child: _galleryImage(controller.galleryImages[1], height: 200)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(child: _galleryImage(controller.galleryImages[2], height: 120)),
              const SizedBox(width: 2),
              Expanded(child: _galleryImage(controller.galleryImages[3], height: 120)),
              const SizedBox(width: 2),
              Expanded(
                child: Stack(
                  children: [
                    _galleryImage(controller.galleryImages[4], height: 120),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                      child: const Center(
                        child: Text('+65', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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
  }

  Widget _galleryImage(String url, {required double height}) {
    return Image.network(url, height: height, fit: BoxFit.cover);
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price for 2 nights, 2 adults', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('PKR 18,808', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(height: 2),
                    Text('+PKR 6,502.52 taxes and charges', style: TextStyle(color: AppColors.darkGrey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.mediumGrey),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.lightGrey),
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
          _buildAttractionCategory(Icons.location_on_outlined, 'Top attractions'),
          _buildNearbyItem('Jumeirah Burj Al Arab', '7 min (6 km)', Icons.directions_car),
          _buildNearbyItem('Burj Khalifa', '12 min (14 km)', Icons.directions_car),
          _buildNearbyItem('The Dubai Fountain', '14 min (15 km)', Icons.directions_car),
          const SizedBox(height: 24),
          _buildAttractionCategory(Icons.directions_walk, 'What\'s nearby'),
          _buildNearbyItem('Al Barsha Pond Park', '24 min (2 km)', Icons.directions_walk),
          _buildNearbyItem('Scream House Recreational Playground', '7 min (5 km)', Icons.directions_car),
          _buildNearbyItem('Dubai Turtle Rehabilitation Project', '6 min (5 km)', Icons.directions_car),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF003580), borderRadius: BorderRadius.circular(4)),
                child: const Text('8.4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Very good', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('See all 6551 reviews', style: TextStyle(color: AppColors.darkGrey, fontSize: 12)),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          _buildReviewCriteria('Cleanliness', 8.8),
          _buildReviewCriteria('Comfort', 8.8),
          _buildReviewCriteria('Facilities', 8.5),
          _buildReviewCriteria('Location', 8.8),
        ],
      ),
    );
  }

  Widget _buildReviewCriteria(String label, double score) {
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
          LinearProgressIndicator(
            value: score / 10,
            backgroundColor: AppColors.lightGrey,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            minHeight: 4,
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
                    Text('Fri 22 May', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF006CE4))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check-out', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('Sun 24 May', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF006CE4))),
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
}
