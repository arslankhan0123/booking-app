import 'package:get/get.dart';
import '../../modules/main/bindings/main_binding.dart';
import '../../modules/main/views/main_view.dart';
import '../../modules/genius/bindings/genius_binding.dart';
import '../../modules/genius/views/genius_view.dart';
import '../../modules/destination_deals/bindings/destination_deals_binding.dart';
import '../../modules/destination_deals/views/destination_deals_view.dart';
import '../../modules/getaway_deals/bindings/getaway_deals_binding.dart';
import '../../modules/getaway_deals/views/getaway_deals_view.dart';
import '../../modules/attractions/bindings/attractions_binding.dart';
import '../../modules/attractions/views/attractions_view.dart';
import '../../modules/hotel_details/bindings/hotel_details_binding.dart';
import '../../modules/hotel_details/views/hotel_details_view.dart';
import '../../modules/search/views/destination_search_view.dart';
import '../../modules/search/views/search_results_view.dart';
import '../../modules/search/views/filters_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.GENIUS,
      page: () => const GeniusView(),
      binding: GeniusBinding(),
    ),
    GetPage(
      name: Routes.DESTINATION_DEALS,
      page: () => const DestinationDealsView(),
      binding: DestinationDealsBinding(),
    ),
    GetPage(
      name: Routes.GETAWAY_DEALS,
      page: () => const GetawayDealsView(),
      binding: GetawayDealsBinding(),
    ),
    GetPage(
      name: Routes.ATTRACTIONS,
      page: () => const AttractionsView(),
      binding: AttractionsBinding(),
    ),
    GetPage(
      name: Routes.HOTEL_DETAILS,
      page: () => const HotelDetailsView(),
      binding: HotelDetailsBinding(),
    ),
    GetPage(
      name: Routes.DESTINATION_SEARCH,
      page: () => const DestinationSearchView(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULTS,
      page: () => const SearchResultsView(),
    ),
    GetPage(
      name: Routes.FILTERS,
      page: () => const FiltersView(),
    ),
  ];
}
