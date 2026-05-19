import 'package:get/get.dart';
import '../controllers/attractions_controller.dart';

class AttractionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttractionsController>(() => AttractionsController());
  }
}
