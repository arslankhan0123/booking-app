import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../../saved/controllers/saved_controller.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<SearchScreenController>(() => SearchScreenController());
    Get.lazyPut<SavedController>(() => SavedController());
    Get.lazyPut<BookingsController>(() => BookingsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
