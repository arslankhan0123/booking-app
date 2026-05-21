import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final selectedCategory = 0.obs;
  final searchText = 'Where are you going?'.obs;
  final destinationSearchQuery = ''.obs;

  // Car rental fields
  final carReturnSameLocation = true.obs;
  final carPickUpLocation = 'Pick-up location'.obs;
  final carDates = '22 May, 10:00 am - 25 May, 10:00 am'.obs;
  final carDriverAge = 'Driver\'s age: 30-65'.obs;

  // Taxi fields
  final taxiTripType = 'one-way'.obs;
  final taxiPickUpLocation = 'Enter pick-up location'.obs;
  final taxiDestination = 'Enter destination'.obs;
  final taxiPickUpTime = 'Choose your pick-up time'.obs;
  final taxiPassengersCount = '2 passengers'.obs;

  // Filter fields
  final minBudgetPrice = 1000.0.obs;
  final maxBudgetPrice = 60000.0.obs;
  final filterHotels = false.obs;
  final filterBreakfast = false.obs;
  final filterFreeCancellation = false.obs;
  final filterPrivateBathroom = false.obs;
  final filterVeryGood = false.obs;
  final filterPropHotels = false.obs;
  final filterPropApartments = false.obs;
  final filterPropHolidayHomes = false.obs;
  final matchingPropertiesCount = 1309.obs;

  // Search results fields
  final showPromoBanner = true.obs;
  final selectedSortOption = 'Our top picks'.obs;

  final sortOptions = [
    'Our top picks',
    'Homes & apartments first',
    'Price (lowest first)',
    'Best reviewed & lowest price',
    'Property rating (high to low)',
    'Property rating (low to high)',
  ];

  final categories = [
    {'name': 'Stays', 'icon': 0xe31d},
    {'name': 'Car rental', 'icon': 0xe123},
    {'name': 'Taxi', 'icon': 0xe365},
    {'name': 'Attractions', 'icon': 0xe3e6},
  ];

  final cities = [
    {
      'name': 'Karachi',
      'image': 'https://images.unsplash.com/photo-1567157577867-05ccb1388e66?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Lahore',
      'image': 'https://images.unsplash.com/photo-1599413987323-b2b8c0d7d9c8?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Islamabad',
      'image': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Dubai',
      'image': 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Istanbul',
      'image': 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=400&auto=format&fit=crop&q=60',
    },
  ];

  final weekendDeals = [
    {
      'name': 'Pearl Continental Hotel Karachi',
      'rating': '8.5',
      'reviewText': 'Excellent',
      'reviews': '2,341',
      'location': 'Karachi, Pakistan',
      'nights': '2 nights',
      'oldPrice': 'PKR 45,000',
      'newPrice': 'PKR 32,000',
    },
    {
      'name': 'Avari Towers Karachi',
      'rating': '8.2',
      'reviewText': 'Very Good',
      'reviews': '1,892',
      'location': 'Karachi, Pakistan',
      'nights': '2 nights',
      'oldPrice': 'PKR 38,000',
      'newPrice': 'PKR 28,500',
    },
    {
      'name': 'Serena Hotel Islamabad',
      'rating': '9.0',
      'reviewText': 'Superb',
      'reviews': '3,120',
      'location': 'Islamabad, Pakistan',
      'nights': '2 nights',
      'oldPrice': 'PKR 55,000',
      'newPrice': 'PKR 42,000',
    },
  ];

  final carBrands = [
    'Hertz',
    'Avis',
    'Budget',
    'Enterprise',
    'Sixt',
    'Europcar',
    'Alamo',
    'National',
  ];

  final continueSearches = [
    {
      'title': 'Karachi',
      'subtitle': '22 May - 24 May · 1 room · 2 adults',
      'image': 'https://images.unsplash.com/photo-1567157577867-05ccb1388e66?w=400&auto=format&fit=crop&q=60',
    },
    {
      'title': 'Lahore',
      'subtitle': '25 May - 27 May · 1 room · 2 adults',
      'image': 'https://images.unsplash.com/photo-1599413987323-b2b8c0d7d9c8?w=400&auto=format&fit=crop&q=60',
    },
  ];

  final lastMinuteDeals = [
    {
      'name': 'Marriott Hotel Karachi',
      'location': 'Karachi',
      'distance': '1.8 km from centre',
      'rating': '8.8',
      'reviewText': 'Excellent',
      'oldPrice': 'PKR 52,000',
      'newPrice': 'PKR 38,000',
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Nishat Hotel Lahore',
      'location': 'Lahore',
      'distance': '2.3 km from centre',
      'rating': '8.6',
      'reviewText': 'Excellent',
      'oldPrice': 'PKR 42,000',
      'newPrice': 'PKR 31,000',
      'imageUrl': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Serena Hotel Quetta',
      'location': 'Quetta',
      'distance': '0.5 km from centre',
      'rating': '8.3',
      'reviewText': 'Very Good',
      'oldPrice': 'PKR 35,000',
      'newPrice': 'PKR 26,000',
      'imageUrl': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400&auto=format&fit=crop&q=60',
    },
  ];

  final recentSearches = [
    {
      'title': 'Karachi',
      'subtitle': '22 May - 24 May · 1 room · 2 adults',
    },
    {
      'title': 'Lahore',
      'subtitle': '25 May - 27 May · 1 room · 2 adults',
    },
    {
      'title': 'Dubai',
      'subtitle': '1 Jun - 5 Jun · 1 room · 2 adults',
    },
  ];

  final hotels = <Map<String, dynamic>>[
    {
      'name': 'Pearl Continental Hotel Karachi',
      'rating': 8.5,
      'reviewText': 'Excellent',
      'reviewsCount': 2341,
      'distanceText': '2.1 km from centre',
      'stars': 5,
      'hasPreferredBadge': true,
      'hasGeniusDiscount': false,
      'oldPrice': 45000.0,
      'newPrice': 32000.0,
      'nights': 2,
      'adults': 2,
      'taxesText': '+PKR 4,800 taxes and charges',
      'hasFreeCancellation': true,
      'hasNoPrepayment': true,
      'isLeftPriceWarning': false,
      'leftPriceWarningText': '',
      'bedsText': '1 king bed',
      'customBadges': ['Mobile price'],
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Avari Towers Karachi',
      'rating': 8.2,
      'reviewText': 'Very Good',
      'reviewsCount': 1892,
      'distanceText': '3.5 km from centre',
      'stars': 5,
      'hasPreferredBadge': false,
      'hasGeniusDiscount': true,
      'oldPrice': 38000.0,
      'newPrice': 28500.0,
      'nights': 2,
      'adults': 2,
      'taxesText': '+PKR 3,900 taxes and charges',
      'hasFreeCancellation': true,
      'hasNoPrepayment': false,
      'isLeftPriceWarning': true,
      'leftPriceWarningText': 'Only 2 rooms left!',
      'bedsText': '2 twin beds',
      'customBadges': [],
      'imageUrl': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Marriott Hotel Karachi',
      'rating': 8.8,
      'reviewText': 'Excellent',
      'reviewsCount': 3120,
      'distanceText': '1.8 km from centre',
      'stars': 5,
      'hasPreferredBadge': true,
      'hasGeniusDiscount': true,
      'oldPrice': 52000.0,
      'newPrice': 38000.0,
      'nights': 2,
      'adults': 2,
      'taxesText': '+PKR 5,200 taxes and charges',
      'hasFreeCancellation': false,
      'hasNoPrepayment': true,
      'isLeftPriceWarning': false,
      'leftPriceWarningText': '',
      'bedsText': '1 king bed',
      'customBadges': ['Breakfast included'],
      'imageUrl': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Ramada by Wyndham Karachi',
      'rating': 7.9,
      'reviewText': 'Good',
      'reviewsCount': 987,
      'distanceText': '4.2 km from centre',
      'stars': 4,
      'hasPreferredBadge': false,
      'hasGeniusDiscount': false,
      'oldPrice': 0.0,
      'newPrice': 22000.0,
      'nights': 2,
      'adults': 2,
      'taxesText': '+PKR 2,800 taxes and charges',
      'hasFreeCancellation': true,
      'hasNoPrepayment': true,
      'isLeftPriceWarning': false,
      'leftPriceWarningText': '',
      'bedsText': '1 double bed',
      'customBadges': [],
      'imageUrl': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Movenpick Hotel Karachi',
      'rating': 8.6,
      'reviewText': 'Excellent',
      'reviewsCount': 2654,
      'distanceText': '0.9 km from centre',
      'stars': 5,
      'hasPreferredBadge': true,
      'hasGeniusDiscount': false,
      'oldPrice': 60000.0,
      'newPrice': 44000.0,
      'nights': 2,
      'adults': 2,
      'taxesText': '+PKR 6,100 taxes and charges',
      'hasFreeCancellation': true,
      'hasNoPrepayment': false,
      'isLeftPriceWarning': true,
      'leftPriceWarningText': 'Last room!',
      'bedsText': '1 king bed',
      'customBadges': ['Free airport taxi', 'Breakfast included'],
      'imageUrl': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400&auto=format&fit=crop&q=60',
    },
  ].obs;

  final _allSuggestions = <Map<String, String>>[
    {'title': 'Karachi', 'subtitle': 'City in Pakistan', 'type': 'city'},
    {'title': 'Lahore', 'subtitle': 'City in Pakistan', 'type': 'city'},
    {'title': 'Islamabad', 'subtitle': 'Capital of Pakistan', 'type': 'city'},
    {'title': 'Dubai', 'subtitle': 'City in UAE', 'type': 'city'},
    {'title': 'Istanbul', 'subtitle': 'City in Turkey', 'type': 'city'},
    {'title': 'Pearl Continental Hotel', 'subtitle': 'Hotel · Karachi, Pakistan', 'type': 'hotel'},
    {'title': 'Avari Towers', 'subtitle': 'Hotel · Karachi, Pakistan', 'type': 'hotel'},
    {'title': 'Marriott Hotel Karachi', 'subtitle': 'Hotel · Karachi, Pakistan', 'type': 'hotel'},
    {'title': 'Serena Hotel Islamabad', 'subtitle': 'Hotel · Islamabad, Pakistan', 'type': 'hotel'},
    {'title': 'Nishat Hotel Lahore', 'subtitle': 'Hotel · Lahore, Pakistan', 'type': 'hotel'},
  ];

  List<Map<String, String>> getFilteredSuggestions(String query) {
    final q = query.toLowerCase();
    return _allSuggestions
        .where((s) =>
            s['title']!.toLowerCase().contains(q) ||
            s['subtitle']!.toLowerCase().contains(q))
        .toList();
  }

  void resetFilters() {
    minBudgetPrice.value = 1000.0;
    maxBudgetPrice.value = 60000.0;
    filterHotels.value = false;
    filterBreakfast.value = false;
    filterFreeCancellation.value = false;
    filterPrivateBathroom.value = false;
    filterVeryGood.value = false;
    filterPropHotels.value = false;
    filterPropApartments.value = false;
    filterPropHolidayHomes.value = false;
    matchingPropertiesCount.value = 1309;
  }

  void filterHotelsBySearchText(String text) {
    // Re-apply filters and update matching count
    matchingPropertiesCount.value = hotels.length * 261;
  }

  void updateSortOption(String option) {
    selectedSortOption.value = option;
  }
}
