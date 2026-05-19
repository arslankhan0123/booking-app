import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attractions_controller.dart';
import '../../../core/theme/app_colors.dart';

class AttractionsView extends GetView<AttractionsController> {
  const AttractionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondaryYellow, width: 2),
          ),
          child: const Row(
            children: [
              Icon(Icons.arrow_back, size: 20, color: Colors.black),
              SizedBox(width: 12),
              Text(
                'Dubai · 22 May - 24 May',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
        actions: const [SizedBox(width: 16)],
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildSummaryBar(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.attractions.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text('You tapped on:', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
                      ),
                      _buildAttractionCard(controller.attractions[index]),
                    ],
                  );
                }
                return _buildAttractionCard(controller.attractions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip(Icons.search, 'Filter by keyword'),
          _buildFilterChip(Icons.keyboard_arrow_down, 'Location', isDropdown: true),
          _buildFilterChip(Icons.keyboard_arrow_down, 'Review score', isDropdown: true),
        ],
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label, {bool isDropdown = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mediumGrey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (!isDropdown) Icon(icon, size: 18, color: AppColors.darkGrey),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black)),
          if (isDropdown) ...[
            const SizedBox(width: 4),
            Icon(icon, size: 18, color: AppColors.darkGrey),
          ]
        ],
      ),
    );
  }

  Widget _buildSummaryBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('6403 things to do', style: TextStyle(color: AppColors.darkGrey, fontSize: 14)),
          Row(
            children: [
              Icon(Icons.swap_vert, size: 18, color: Color(0xFF006CE4)),
              SizedBox(width: 4),
              Text('Sort', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAttractionCard(Map<String, dynamic> attr) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(attr['image'], width: 120, height: 120, fit: BoxFit.cover),
              ),
              if (attr['isBestseller'] == true)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF003580),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: const Text(
                      'Bestseller',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        attr['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.favorite_border, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${attr['rating']} (${attr['reviews']} reviews)',
                      style: const TextStyle(fontSize: 13, color: AppColors.darkGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('From ${attr['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text('Available from 22 May', style: TextStyle(fontSize: 12, color: AppColors.darkGrey)),
                    ],
                  ),
                ),
                if (attr['freeCancellation'] == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.check, size: 14, color: Color(0xFF008009)),
                        SizedBox(width: 4),
                        Text('Free cancellation available', style: TextStyle(color: Color(0xFF008009), fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
