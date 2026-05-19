import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/saved_controller.dart';
import '../../../core/theme/app_colors.dart';

class SavedView extends GetView<SavedController> {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dummy illustration
              Stack(
                alignment: Alignment.center,
                children: [
                   Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Container(height: 80, color: AppColors.lightGrey),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(radius: 4, backgroundColor: AppColors.secondaryYellow),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.favorite, color: Colors.orange, size: 40),
                  )
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Save what you like for later',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Save your favourites to help plan, compare and book a trip.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.mediumGrey),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
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
                  child: const Text('Start your search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Create a list',
                  style: TextStyle(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
