import 'package:get/get.dart';
import '../controllers/genius_controller.dart';

class GeniusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeniusController>(() => GeniusController());
  }
}
