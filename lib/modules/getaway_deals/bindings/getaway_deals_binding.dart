import 'package:get/get.dart';
import '../controllers/getaway_deals_controller.dart';

class GetawayDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetawayDealsController>(() => GetawayDealsController());
  }
}
