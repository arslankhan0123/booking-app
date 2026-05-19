import 'package:get/get.dart';

class HotelDetailsController extends GetxController {
  final hotelName = 'Flora Al Barsha Hotel At The Mall'.obs;
  final rating = 8.4.obs;
  final address = 'Near Mall of the Emirates, Al Barsha, 8088 , Al Barsha, Dubai, United Arab Emirates'.obs;
  
  final amenities = [
    {'name': 'Free parking', 'icon': 'p_rounded'},
    {'name': 'Outdoor pool', 'icon': 'pool'},
    {'name': 'Restaurant', 'icon': 'restaurant'},
    {'name': 'Spa and wellness centre', 'icon': 'spa'},
    {'name': 'Air conditioning', 'icon': 'ac_unit'},
  ];

  final galleryImages = [
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1000',
    'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1000',
    'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?q=80&w=1000',
    'https://images.unsplash.com/photo-1544161515-4af6b1d8c159?q=80&w=1000',
    'https://images.unsplash.com/photo-1551882547-ff43c63be5c2?q=80&w=1000',
  ];
}
