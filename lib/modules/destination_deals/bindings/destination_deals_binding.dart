import 'package:get/get.dart';
import '../controllers/destination_deals_controller.dart';

class DestinationDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationDealsController>(() => DestinationDealsController());
  }
}
