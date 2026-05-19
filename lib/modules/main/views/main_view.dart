import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../search/views/search_view.dart';
import '../../saved/views/saved_view.dart';
import '../../bookings/views/bookings_view.dart';
import '../../profile/views/profile_view.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex,
            children: const [
              SearchView(),
              SavedView(),
              BookingsView(),
              ProfileView(),
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center_outlined),
                activeIcon: Icon(Icons.business_center),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin_outlined),
                activeIcon: Icon(Icons.person_pin),
                label: 'Sign in',
              ),
            ],
          )),
    );
  }
}
