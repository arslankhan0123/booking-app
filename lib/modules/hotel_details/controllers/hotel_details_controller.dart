import 'package:get/get.dart';

class HotelDetailsController extends GetxController {
  final hotelName = 'Flora Al Barsha Hotel At The Mall'.obs;
  final rating = 8.4.obs;
  final ratingText = 'Very good'.obs;
  final reviewsCount = 6551.obs;
  final address = 'Near Mall of the Emirates, Al Barsha, 8088 , Al Barsha, Dubai, United Arab Emirates'.obs;
  final stars = 4.obs;
  final oldPrice = 'PKR 6,450'.obs;
  final newPrice = 'PKR 5,224'.obs;
  
  final amenities = [
    {'name': 'Free parking', 'icon': 'p_rounded'},
    {'name': 'Outdoor pool', 'icon': 'pool'},
    {'name': 'Restaurant', 'icon': 'restaurant'},
    {'name': 'Spa and wellness centre', 'icon': 'spa'},
    {'name': 'Air conditioning', 'icon': 'ac_unit'},
  ];

  final galleryImages = <String>[
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1000',
    'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1000',
    'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?q=80&w=1000',
    'https://images.unsplash.com/photo-1544161515-4af6b1d8c159?q=80&w=1000',
    'https://images.unsplash.com/photo-1551882547-ff43c63be5c2?q=80&w=1000',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final data = Get.arguments as Map<String, dynamic>;
      if (data.containsKey('name')) hotelName.value = data['name'] as String;
      if (data.containsKey('rating')) {
        final r = data['rating'];
        if (r is double) rating.value = r;
        if (r is int) rating.value = r.toDouble();
        if (r is String) rating.value = double.tryParse(r) ?? 8.4;
      }
      if (data.containsKey('reviewText')) ratingText.value = data['reviewText'] as String;
      if (data.containsKey('reviewsCount')) {
        final c = data['reviewsCount'];
        if (c is int) reviewsCount.value = c;
        if (c is String) reviewsCount.value = int.tryParse(c) ?? 6551;
      }
      if (data.containsKey('address')) address.value = data['address'] as String;
      if (data.containsKey('stars')) {
        final s = data['stars'];
        if (s is int) stars.value = s;
      }
      if (data.containsKey('oldPrice')) oldPrice.value = data['oldPrice'] as String;
      if (data.containsKey('newPrice')) newPrice.value = data['newPrice'] as String;
      
      if (data.containsKey('gallery') && data['gallery'] is List) {
        final list = data['gallery'] as List;
        galleryImages.assignAll(list.map((e) => e.toString()).toList());
      } else if (data.containsKey('imageUrl')) {
        galleryImages[0] = data['imageUrl'] as String;
      }
    }
  }
}
