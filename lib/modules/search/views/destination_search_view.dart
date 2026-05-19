import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../core/theme/app_colors.dart';

class DestinationSearchView extends GetView<SearchScreenController> {
  const DestinationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    controller.destinationSearchQuery.value = '';
    final TextEditingController textController = TextEditingController(
      text: controller.searchText.value == 'Around current location' ? '' : controller.searchText.value,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Yellow bordered search header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.secondaryYellow, width: 3.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        autofocus: true,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Enter destination',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          controller.destinationSearchQuery.value = value;
                        },
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            controller.searchText.value = value.trim();
                            Get.toNamed('/search-results');
                          }
                        },
                      ),
                    ),
                    Obx(() => controller.destinationSearchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            textController.clear();
                            controller.destinationSearchQuery.value = '';
                          },
                        )
                      : const SizedBox.shrink()
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Dynamic body: autocomplete suggestions OR default search options
            Expanded(
              child: Obx(() {
                final query = controller.destinationSearchQuery.value;
                if (query.trim().isEmpty) {
                  return ListView(
                    children: [
                      // Around current location
                      InkWell(
                        onTap: () {
                          controller.searchText.value = 'Around current location';
                          Get.toNamed('/search-results');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF4FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.my_location,
                                  color: AppColors.accentBlue,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                'Around current location',
                                style: TextStyle(
                                  color: AppColors.accentBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Section: Continue your search
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Continue your search',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.recentSearches.length,
                        itemBuilder: (context, index) {
                          final search = controller.recentSearches[index];
                          return InkWell(
                            onTap: () {
                              controller.searchText.value = search['title']!;
                              Get.toNamed('/search-results');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF4FF),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.history,
                                      color: AppColors.accentBlue,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          search['title']!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          search['subtitle']!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.mediumGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Show more
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Show more',
                              style: TextStyle(
                                color: AppColors.accentBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1, thickness: 1, color: Color(0xFFEAEAEA)),
                      // Find cheap flights
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF4FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.flight_takeoff,
                                  color: AppColors.accentBlue,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                'Find cheap flights',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Autocomplete suggestions
                  final filtered = controller.getFilteredSuggestions(query);
                  if (filtered.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No results found', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    );
                  }
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      IconData typeIcon = Icons.location_on;
                      if (item['type'] == 'hotel') {
                        typeIcon = Icons.hotel;
                      } else if (item['type'] == 'apartment') {
                        typeIcon = Icons.home;
                      }
                      return InkWell(
                        onTap: () {
                          controller.searchText.value = item['title']!;
                          Get.toNamed('/search-results');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF4FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  typeIcon,
                                  color: AppColors.accentBlue,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title']!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item['subtitle']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.mediumGrey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
