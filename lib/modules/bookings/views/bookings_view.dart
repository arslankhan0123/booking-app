import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookings_controller.dart';
import '../../../core/theme/app_colors.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.filters.length,
              itemBuilder: (context, index) {
                return Obx(() => GestureDetector(
                      onTap: () => controller.selectedFilter.value = index,
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: controller.selectedFilter.value == index
                              ? const Color(0xFFE8F1FF)
                              : Colors.white,
                          border: Border.all(
                            color: controller.selectedFilter.value == index
                                ? AppColors.accentBlue
                                : AppColors.mediumGrey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            controller.filters[index],
                            style: TextStyle(
                              color: controller.selectedFilter.value == index
                                  ? AppColors.accentBlue
                                  : AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
          
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Dummy Globe Illustration
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F7FF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                          )
                        ]
                      ),
                      child: const Icon(Icons.public, size: 100, color: AppColors.secondaryYellow),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'No bookings yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sign in or create an account to get started.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: AppColors.mediumGrey),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text('Sign in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
