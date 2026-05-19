import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../core/theme/app_colors.dart';

class FiltersView extends StatelessWidget {
  const FiltersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchScreenController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.resetFilters();
              controller.filterHotelsBySearchText(controller.searchText.value);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Budget section
                  const Text(
                    'Your budget (for 2 nights)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    final minFmt = controller.minBudgetPrice.value.toStringAsFixed(0).replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
                    final maxFmt = controller.maxBudgetPrice.value.toStringAsFixed(0).replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
                    final suffix = controller.maxBudgetPrice.value >= 60000.0 ? ' +' : '';
                    return Text(
                      'PKR $minFmt - PKR $maxFmt$suffix',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  _buildPriceHistogram(controller),
                  const SizedBox(height: 8),
                  const Divider(height: 32, thickness: 1),

                  // Popular filters section
                  const Text(
                    'Popular filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFilterCheckboxTile('Hotels (487)', controller.filterHotels),
                  _buildFilterCheckboxTile('Breakfast included (331)', controller.filterBreakfast),
                  _buildFilterCheckboxTile('Free cancellation (1303)', controller.filterFreeCancellation),
                  _buildFilterCheckboxTile('Private bathroom (1049)', controller.filterPrivateBathroom),
                  _buildFilterCheckboxTile('Very good: 8+ (414)', controller.filterVeryGood),
                  
                  GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Show more',
                        style: TextStyle(
                          color: AppColors.accentBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 32, thickness: 1),

                  // Property type section
                  const Text(
                    'Property type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFilterCheckboxTile('Hotels (487)', controller.filterPropHotels),
                  _buildFilterCheckboxTile('Apartments (692)', controller.filterPropApartments),
                  _buildFilterCheckboxTile('Holiday homes (39)', controller.filterPropHolidayHomes),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom show results bar
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  '${controller.matchingPropertiesCount} matching properties',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      controller.filterHotelsBySearchText(controller.searchText.value);
                      Get.back();
                    },
                    child: const Text(
                      'Show results',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceHistogram(SearchScreenController controller) {
    final barHeights = [
      10, 15, 8, 25, 30, 45, 38, 55, 62, 50, 72, 85, 78, 68, 72, 60,
      58, 48, 50, 42, 38, 44, 30, 32, 24, 28, 20, 15, 18, 12, 10, 14,
      8, 6, 9, 5, 7, 4, 3, 2
    ];
    return Obx(() {
      final minVal = controller.minBudgetPrice.value;
      final maxVal = controller.maxBudgetPrice.value;
      return Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(barHeights.length, (index) {
                final barPrice = 1000.0 + index * (59000.0 / (barHeights.length - 1));
                final isActive = barPrice >= minVal && barPrice <= maxVal;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: barHeights[index].toDouble(),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.accentBlue : Colors.grey.shade300,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                    ),
                  ),
                );
              }),
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: AppColors.accentBlue,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: AppColors.accentBlue,
              overlayColor: AppColors.accentBlue.withOpacity(0.12),
              rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: RangeSlider(
              values: RangeValues(minVal, maxVal),
              min: 1000,
              max: 60000,
              divisions: 59,
              onChanged: (values) {
                controller.minBudgetPrice.value = values.start;
                controller.maxBudgetPrice.value = values.end;
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildFilterCheckboxTile(String label, RxBool value) {
    return InkWell(
      onTap: () => value.toggle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
            Obx(() => SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value.value,
                onChanged: (val) => value.value = val ?? false,
                activeColor: AppColors.accentBlue,
                checkColor: Colors.white,
                side: const BorderSide(color: Colors.grey, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
