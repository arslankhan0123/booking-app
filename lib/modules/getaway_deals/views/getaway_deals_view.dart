import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/getaway_deals_controller.dart';
import '../../../core/theme/app_colors.dart';

class GetawayDealsView extends GetView<GetawayDealsController> {
  const GetawayDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking.com'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroHeader(),
            _buildSearchCard(),
            _buildInfoCard(),
            _buildDealsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=1000'), // Beach couple placeholder
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Getaway Deals',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'At least 15% off select stays.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Transform.translate(
        offset: const Offset(0, -30),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryYellow,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                _buildSearchItem(Icons.search, 'Flora Al Barsha Hotel At The Mall'),
                const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1),
                _buildSearchItem(Icons.calendar_today_outlined, 'Fri 22 May - Sun 24 May'),
                const Divider(height: 1, color: AppColors.secondaryYellow, thickness: 1),
                _buildSearchItem(Icons.person_outline, '1 room · 2 adults · 0 children'),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkGrey, size: 24),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildInfoRow(Icons.check, 'Book anytime until 30 September 2026'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today_outlined, 'Stay between 26 March–30 September 2026'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.percent_outlined, 'Save 15% or more'),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Conditions apply', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.darkGrey),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }

  Widget _buildDealsList() {
    return Column(
      children: controller.deals.map((dest) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(dest['image']!, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dest['name']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF008009), borderRadius: BorderRadius.circular(4)),
                    child: Text(dest['dealsCount']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  Text('From ${dest['price']} per night', style: const TextStyle(fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      )).toList(),
    );
  }
}
