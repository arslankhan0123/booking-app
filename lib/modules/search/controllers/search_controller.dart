import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final selectedCategory = 0.obs;
  
  final categories = [
    {'name': 'Stays', 'icon': 0xe31d}, // hotel
    {'name': 'Car rental', 'icon': 0xe123}, // directions_car
    {'name': 'Taxi', 'icon': 0xe365}, // local_taxi
    {'name': 'Attractions', 'icon': 0xe3e6}, // local_activity
  ];

  // Dummy data for "Need ideas?"
  final cities = [
    {'name': 'Lahore', 'image': 'https://placeholder.com/lahore'},
    {'name': 'Islamabad', 'image': 'https://placeholder.com/islamabad'},
  ];

  // Dummy data for "Deals for the weekend"
  final weekendDeals = [
    {
      'name': 'Flora Al Barsha Hotel At The Mall',
      'rating': '8.4',
      'reviewText': 'Very good',
      'reviews': '6551',
      'location': 'Dubai',
      'oldPrice': 'PKR 25,488',
      'newPrice': 'PKR 20,429',
      'nights': '2 nights'
    },
    {
      'name': 'Elite Escape Holiday',
      'rating': '8.8',
      'reviewText': 'Fabulous',
      'reviews': '22',
      'location': 'Dubai',
      'oldPrice': 'PKR 30,343',
      'newPrice': 'PKR 25,000',
      'nights': '2 nights'
    },
  ];

  // Car hire brands
  final carBrands = [
    'Alamo', 'AVIS', 'Budget', 'dollar.', 'enterprise', 'Europcar', 'GREEN MOTION', 'Hertz'
  ];

  // Search State
  final searchText = 'Around current location'.obs;
  final selectedSortOption = 'Distance from place of interest'.obs;
  final destinationSearchQuery = ''.obs;
  final showPromoBanner = true.obs;

  // Filters State
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

  int get matchingPropertiesCount {
    int count = 1412;
    if (filterHotels.value) count -= 300;
    if (filterBreakfast.value) count -= 200;
    if (filterFreeCancellation.value) count -= 150;
    if (filterPrivateBathroom.value) count -= 120;
    if (filterVeryGood.value) count -= 180;
    if (filterPropApartments.value) count -= 400;
    if (filterPropHolidayHomes.value) count -= 80;
    
    // Budget range factor:
    double rangeFraction = (maxBudgetPrice.value - minBudgetPrice.value) / 59000.0;
    count = (count * rangeFraction).round();
    if (count < 12) count = 12; // lower limit
    return count;
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
  }

  // Suggestions data
  final suggestions = <Map<String, String>>[
    {
      'title': 'Flora Al Barsha Hotel At The Mall',
      'subtitle': 'Hotel · Al Barsha, Dubai, United Arab Emirates',
      'type': 'hotel'
    },
    {
      'title': 'Luxury Apartments in Dubai Marina & JBR',
      'subtitle': 'Apartment · Jumeirah Beach Residence, Dubai',
      'type': 'apartment'
    },
    {
      'title': 'Lahore',
      'subtitle': 'City · Punjab, Pakistan',
      'type': 'city'
    },
  ];

  List<Map<String, String>> getFilteredSuggestions(String query) {
    if (query.isEmpty) return [];
    return suggestions.where((item) =>
      item['title']!.toLowerCase().contains(query.toLowerCase()) ||
      item['subtitle']!.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Recent Searches
  final recentSearches = <Map<String, String>>[
    {
      'title': 'Flora Al Barsha Hotel At The Mall',
      'subtitle': '22 May-24 May, 2 adults',
    },
    {
      'title': 'Lahore',
      'subtitle': '22 May-23 May, 2 adults',
    },
    {
      'title': 'Avari Xpress Gulberg',
      'subtitle': '17 May-18 May, 2 adults',
    },
  ].obs;

  // Stays / Hotels data
  final hotels = <Map<String, dynamic>>[].obs;

  final sortOptions = <String>[
    'Entire homes & apartments first',
    'Distance from place of interest',
    'Our top picks',
    'Property rating (high to low)',
    'Property rating (low to high)',
    'Genius discounts first',
    'Guest review score',
    'Price (low to high)',
  ];

  final List<Map<String, dynamic>> _masterHotelsList = [];

  @override
  void onInit() {
    super.onInit();
    _initializeMasterHotels();
    // Watch search text changes to auto-filter hotels
    ever(searchText, (value) {
      filterHotelsBySearchText(value);
    });
    filterHotelsBySearchText(searchText.value);
  }

  void _initializeMasterHotels() {
    _masterHotelsList.assignAll([
      {
        'name': 'Flora Al Barsha Hotel At The Mall',
        'stars': 4,
        'hasPreferredBadge': true,
        'rating': 8.4,
        'reviewText': 'Very good',
        'reviewsCount': 6539,
        'distanceFromCenter': 0.3,
        'distanceText': 'Al Barsha · 7.2 miles from centre',
        'type': 'Hotel room',
        'bedsText': 'Hotel room: 1 bed',
        'hasFreeCancellation': false,
        'hasNoPrepayment': false,
        'isLeftPriceWarning': false,
        'leftPriceWarningText': '',
        'oldPrice': 31288.0,
        'newPrice': 25043.0,
        'taxesText': '+PKR 8,400 taxes and charges',
        'nights': 2,
        'adults': 2,
        'hasGeniusDiscount': true,
        'isEntireHomeOrApartment': false,
        'imageUrl': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=500&auto=format&fit=crop&q=60',
      },
      {
        'name': 'Luxury Apartments in Dubai Marina & JBR',
        'stars': 0,
        'hasPreferredBadge': false,
        'rating': 9.4,
        'reviewText': 'Superb',
        'reviewsCount': 12,
        'distanceFromCenter': 0.5,
        'distanceText': 'Jumeirah Beach Residence · 12.3 miles from centre',
        'type': 'Entire apartment',
        'bedsText': 'Entire apartment: 9 beds · 2 bedrooms · 2 bathrooms',
        'customBadges': ['Free airport taxi', 'Limited-time Deal'],
        'hasFreeCancellation': false,
        'hasNoPrepayment': false,
        'isLeftPriceWarning': false,
        'leftPriceWarningText': '',
        'oldPrice': 136528.0,
        'newPrice': 95569.0,
        'taxesText': '+PKR 52,563 taxes and charges',
        'nights': 2,
        'adults': 2,
        'hasGeniusDiscount': false,
        'isEntireHomeOrApartment': true,
        'imageUrl': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=500&auto=format&fit=crop&q=60',
      },
      {
        'name': 'Wavy Designer Apartment MM Alam road',
        'stars': 0,
        'hasPreferredBadge': false,
        'rating': 7.0,
        'reviewText': 'Good',
        'reviewsCount': 1,
        'distanceFromCenter': 0.05,
        'distanceText': '100 yards from you',
        'type': 'Entire apartment',
        'bedsText': '2 beds · 1 bedroom · 1 living room · 1 bathroom',
        'hasFreeCancellation': true,
        'hasNoPrepayment': true,
        'isLeftPriceWarning': true,
        'leftPriceWarningText': 'Only 2 left at this price on Booking.com',
        'oldPrice': 18000.0,
        'newPrice': 14000.0,
        'taxesText': '+PKR 3,000 taxes and charges',
        'nights': 2,
        'adults': 2,
        'hasGeniusDiscount': false,
        'isEntireHomeOrApartment': true,
        'imageUrl': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=500&auto=format&fit=crop&q=60',
      },
      {
        'name': 'Avari Xpress Gulberg',
        'stars': 3,
        'hasPreferredBadge': false,
        'rating': 8.0,
        'reviewText': 'Very good',
        'reviewsCount': 150,
        'distanceFromCenter': 0.1,
        'distanceText': '0.1 miles from center',
        'type': 'Hotel room',
        'bedsText': '2 single beds · 1 bathroom',
        'hasFreeCancellation': false,
        'hasNoPrepayment': true,
        'isLeftPriceWarning': true,
        'leftPriceWarningText': 'Only 1 room left!',
        'oldPrice': 19000.0,
        'newPrice': 16500.0,
        'taxesText': '+PKR 2,500 taxes and charges',
        'nights': 2,
        'adults': 2,
        'hasGeniusDiscount': false,
        'isEntireHomeOrApartment': false,
        'imageUrl': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500&auto=format&fit=crop&q=60',
      },
      {
        'name': 'Premium Residency Liberty',
        'stars': 0,
        'hasPreferredBadge': true,
        'rating': 9.1,
        'reviewText': 'Superb',
        'reviewsCount': 48,
        'distanceFromCenter': 0.8,
        'distanceText': '0.8 miles from center',
        'type': 'Entire apartment',
        'bedsText': '3 beds · 2 bedrooms · 1 living room · 2 bathrooms',
        'hasFreeCancellation': true,
        'hasNoPrepayment': true,
        'isLeftPriceWarning': false,
        'leftPriceWarningText': '',
        'oldPrice': 15000.0,
        'newPrice': 12000.0,
        'taxesText': '+PKR 1,800 taxes and charges',
        'nights': 2,
        'adults': 2,
        'hasGeniusDiscount': true,
        'isEntireHomeOrApartment': true,
        'imageUrl': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=500&auto=format&fit=crop&q=60',
      },
    ]);
  }

  void filterHotelsBySearchText(String query) {
    List<Map<String, dynamic>> filtered = List.from(_masterHotelsList);
    
    // 1. Query matching
    if (query.trim().isNotEmpty && query.toLowerCase() != 'around current location') {
      final lowercaseQuery = query.toLowerCase();
      filtered = filtered.where((hotel) {
        final name = (hotel['name'] as String).toLowerCase();
        final distance = (hotel['distanceText'] as String).toLowerCase();
        final beds = (hotel['bedsText'] as String).toLowerCase();
        return name.contains(lowercaseQuery) || 
               distance.contains(lowercaseQuery) || 
               beds.contains(lowercaseQuery);
      }).toList();
    }

    // 2. Budget matching
    filtered = filtered.where((hotel) {
      final price = hotel['newPrice'] as double;
      return price >= minBudgetPrice.value && price <= maxBudgetPrice.value;
    }).toList();

    // 3. Popular filters checkboxes
    if (filterFreeCancellation.value) {
      filtered = filtered.where((hotel) => hotel['hasFreeCancellation'] == true).toList();
    }
    if (filterVeryGood.value) {
      filtered = filtered.where((hotel) => (hotel['rating'] as double) >= 8.0).toList();
    }
    if (filterPropApartments.value) {
      filtered = filtered.where((hotel) => hotel['isEntireHomeOrApartment'] == true).toList();
    }

    hotels.assignAll(filtered);
    sortHotels();
  }

  void updateSortOption(String option) {
    selectedSortOption.value = option;
    sortHotels();
  }

  void sortHotels() {
    switch (selectedSortOption.value) {
      case 'Distance from place of interest':
        hotels.sort((a, b) => (a['distanceFromCenter'] as double).compareTo(b['distanceFromCenter'] as double));
        break;
      case 'Entire homes & apartments first':
        hotels.sort((a, b) {
          int aVal = (a['isEntireHomeOrApartment'] as bool) ? 0 : 1;
          int bVal = (b['isEntireHomeOrApartment'] as bool) ? 0 : 1;
          return aVal.compareTo(bVal);
        });
        break;
      case 'Our top picks':
        hotels.sort((a, b) => (b['reviewsCount'] as int).compareTo(a['reviewsCount'] as int));
        break;
      case 'Property rating (high to low)':
        hotels.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        break;
      case 'Property rating (low to high)':
        hotels.sort((a, b) => (a['rating'] as double).compareTo(b['rating'] as double));
        break;
      case 'Genius discounts first':
        hotels.sort((a, b) {
          int aVal = (a['hasGeniusDiscount'] as bool) ? 0 : 1;
          int bVal = (b['hasGeniusDiscount'] as bool) ? 0 : 1;
          return aVal.compareTo(bVal);
        });
        break;
      case 'Guest review score':
        hotels.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        break;
      case 'Price (low to high)':
        hotels.sort((a, b) => (a['newPrice'] as double).compareTo(b['newPrice'] as double));
        break;
    }
    hotels.refresh();
  }
}
