import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../core/theme/app_colors.dart';

class SearchResultsView extends GetView<SearchScreenController> {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Background content
          Column(
            children: [
              // Blue background header block
              Container(
                height: MediaQuery.of(context).padding.top + 40,
                color: AppColors.primaryBlue,
              ),
              // Spacer corresponding to half-height of the search card (54 / 2 = 27)
              const SizedBox(height: 27),
              // Navigation bar (Sort, Filter, Map)
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                    bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _showSortBottomSheet(context),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.swap_vert, color: Colors.black87),
                                SizedBox(width: 6),
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            // Red dot badge for Sort
                            Positioned(
                              top: 14,
                              right: 48,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.toNamed('/filters'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.tune, color: Colors.black87),
                            SizedBox(width: 6),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.map_outlined, color: Colors.black87),
                            SizedBox(width: 6),
                            Text(
                              'Map',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter chips horizontal scroll
              Container(
                color: Colors.white,
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    _buildFilterChip('Hotels (726)'),
                    _buildFilterChip('Breakfast included (627)'),
                    _buildFilterChip('Very good: 8'),
                    _buildFilterChip('Free cancellation'),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

              // Property count header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      '${controller.hotels.length * 1309} properties',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Obx(
                  () {
                    final showBanner = controller.showPromoBanner.value;
                    final itemCount = controller.hotels.length + (showBanner ? 1 : 0);
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        if (showBanner && index == 2) {
                          return _buildPromoBannerCard();
                        }
                        final actualIndex = (showBanner && index > 2) ? index - 1 : index;
                        if (actualIndex >= controller.hotels.length) {
                          return const SizedBox.shrink();
                        }
                        final hotel = controller.hotels[actualIndex];
                        return _buildHotelCard(hotel);
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // Overlapping Search Bar positioned exactly half-on-blue, half-on-white
          Positioned(
            top: MediaQuery.of(context).padding.top + 13,
            left: 16,
            right: 16,
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.secondaryYellow, width: 3.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.toNamed('/destination-search'),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Obx(
                          () => Text(
                            '${controller.searchText.value} · 22 May - 24 May',
                            style: const TextStyle(
                              fontSize: 15.5,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBannerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Book a stay and get a free private taxi from the airport',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'From prices PKR 67,700 · Valid for select properties',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1492664738948-2ec93a5c0e6d?w=300&auto=format&fit=crop&q=60',
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.local_taxi, size: 50, color: Colors.amber);
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                controller.showPromoBanner.value = false;
              },
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, size: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    final rating = hotel['rating'] as double;
    final reviewsCount = hotel['reviewsCount'] as int;
    final oldPrice = hotel['oldPrice'] as double;
    final newPrice = hotel['newPrice'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Side: Hotel Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: SizedBox(
                width: 125,
                child: Image.network(
                  hotel['imageUrl'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightGrey,
                      child: const Icon(Icons.hotel, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),

          // Right Side: Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name & Heart Favorite Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.favorite_border, color: Colors.grey, size: 22),
                    ],
                  ),

                  // Stars, Preferred Partner & Genius Badges
                  if ((hotel['stars'] != null && hotel['stars'] > 0) ||
                      (hotel['hasPreferredBadge'] == true) ||
                      (hotel['hasGeniusDiscount'] == true)) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (hotel['stars'] != null && hotel['stars'] > 0) ...[
                          Row(
                            children: List.generate(
                              hotel['stars'] as int,
                              (index) => const Icon(Icons.star, color: Colors.amber, size: 14),
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        if (hotel['hasPreferredBadge'] == true) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade700,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.thumb_up, size: 10, color: Colors.white),
                                SizedBox(width: 2),
                                Text('+', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        if (hotel['hasGeniusDiscount'] == true)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003580),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Genius',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 6),

                  // Rating Badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF003580),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hotel['reviewText'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' · $reviewsCount ${reviewsCount == 1 ? 'review' : 'reviews'}',
                          style: const TextStyle(
                            color: AppColors.mediumGrey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Distance / Location info
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.mediumGrey, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hotel['distanceText'] as String,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Custom Badges Row
                  if (hotel['customBadges'] != null) ...[
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: (hotel['customBadges'] as List<dynamic>).map<Widget>((badge) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF008009),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 6),

                  // Room Details
                  Text(
                    hotel['bedsText'] as String,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Free cancellation / No prepayment needed
                  if (hotel['hasFreeCancellation'] == true)
                    Row(
                      children: const [
                        Icon(Icons.check, color: Colors.green, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Free cancellation',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (hotel['hasNoPrepayment'] == true)
                    Row(
                      children: const [
                        Icon(Icons.check, color: Colors.green, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'No prepayment needed',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  // Left warning (red text)
                  if (hotel['isLeftPriceWarning'] == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        hotel['leftPriceWarningText'] as String,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Price Section
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price for ${hotel['nights']} nights, ${hotel['adults']} adults',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (oldPrice > newPrice) ...[
                              Text(
                                'PKR ${oldPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              'PKR ${newPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (hotel['taxesText'] != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            hotel['taxesText'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.mediumGrey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void _showSortBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle indicator
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.sortOptions.length,
                itemBuilder: (context, index) {
                  final option = controller.sortOptions[index];
                  return Obx(() {
                    final isSelected = controller.selectedSortOption.value == option;
                    return InkWell(
                      onTap: () {
                        controller.updateSortOption(option);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.accentBlue : Colors.grey.shade400,
                                  width: isSelected ? 6.5 : 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
