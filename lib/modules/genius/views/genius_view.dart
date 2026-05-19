import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/genius_controller.dart';
import '../../../core/theme/app_colors.dart';

class GeniusView extends GetView<GeniusController> {
  const GeniusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genius loyalty programme'),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroHeader(),
                const SizedBox(height: 180), // Compensation for floating card
                _buildGeniusDiscounts(),
                _buildSavingsSimple(),
                _buildBetterWithGenius(),
                _buildGeniusFAQs(),
                _buildSurveyCard(),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Find your next stay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Image Section
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            image: DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=1000'), // Placeholder for pool background
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get rewarded for being you',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                'Genius',
                style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                'Booking.com\'s loyalty programme',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 40), // Space for floating card
            ],
          ),
        ),
        // Floating Welcome Card
        Positioned(
          top: 170,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'گجر, welcome to Genius!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You\'re at Level 1 and get 10% off select stays and rental cars - just look for the Genius label to save. Next stop, Level 2...',
                  style: TextStyle(fontSize: 14, color: AppColors.darkGrey, height: 1.4),
                ),
                const SizedBox(height: 20),
                // Progress circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.mediumGrey, style: BorderStyle.solid, width: 1.5),
                    ),
                  )),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text('How to progress in Genius', style: TextStyle(color: Color(0xFF006CE4), fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavingsSimple() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text('About Genius Levels', style: TextStyle(color: Color(0xFF006CE4), fontSize: 14)),
          ),
          const SizedBox(height: 8),
          const Text('Savings made simple', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 220,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Background simulated property card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 100, height: 160, color: const Color(0xFFF2F2F2)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 15, width: 140, color: const Color(0xFFE0E0E0)),
                              const SizedBox(height: 8),
                              Container(height: 15, width: 100, color: const Color(0xFFF5F5F5)),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Genius', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 14)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // Magnifying glass overlay
                Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightGrey, width: 6),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                        child: const Text('Genius', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                // Handle of magnifying glass
                Positioned(
                  top: 140,
                  right: 30,
                  child: Transform.rotate(
                    angle: 0.8,
                    child: Container(
                      width: 15,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.darkGrey, fontSize: 15, height: 1.4),
              children: [
                TextSpan(text: 'You\'ll recognise '),
                TextSpan(text: 'participating properties and rental cars', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(text: ' by the blue Genius label. All discounts and rewards are automatically applied when you book – you won\'t have to lift a finger.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('So simple, it\'s Genius.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildBetterWithGenius() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Booking.com is better with Genius', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'Enjoy a lifetime of discounts and travel rewards on hundreds of thousands of stays and rental cars worldwide with Booking.com\'s loyalty programme.',
            style: TextStyle(fontSize: 15, height: 1.4, color: AppColors.darkGrey),
          ),
          const SizedBox(height: 24),
          _buildGeniusStep('Easy to find', 'Once signed in, look for the blue Genius label to find your travel rewards.', const Color(0xFF006CE4)),
          _buildGeniusStep('Easy to keep', 'After unlocking each Genius Level, the rewards are yours to enjoy for life.', const Color(0xFF003580)),
          _buildGeniusStep('Easy to grow', 'The more you book, the more you get. The best part? Every booking counts towards your progress.', const Color(0xFF006CE4)),
        ],
      ),
    );
  }

  Widget _buildGeniusStep(String title, String sub, Color barColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 3, height: 50, color: barColor), // Slightly thinner and shorter
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: barColor)),
                const SizedBox(height: 6),
                Text(sub, style: const TextStyle(fontSize: 14, color: AppColors.darkGrey, height: 1.3)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGeniusDiscounts() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Book your next trip for less', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.darkGrey, fontSize: 15, height: 1.4),
              children: [
                TextSpan(text: 'Enjoy '),
                TextSpan(text: 'free lifetime access', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(text: ' to Genius Level 1 discounts on '),
                TextSpan(text: 'select stays and rental cars', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(text: ' worldwide. Discounts are applied to the price before taxes & charges.'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: const Color(0xFFF1F7FF), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.card_giftcard, color: Color(0xFF006CE4), size: 30),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Genius discounts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          SizedBox(height: 4),
                          Text(
                            'Enjoy savings at 850,000 participating properties worldwide and save on select rental cars',
                            style: TextStyle(color: AppColors.darkGrey, fontSize: 14, height: 1.3),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                _buildLevelItem('Level 1', '10% discounts on stays', true),
                _buildLevelItem('Level 2', '10-15% discounts on stays', false),
                _buildLevelItem('Level 3', '10-20% discounts on stays', false),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: AppColors.lightGrey),
                ),
                _buildLevelItem('Level 1', '10% discounts on rental cars', true),
                _buildLevelItem('Level 2', '10-15% discounts on rental cars', false),
                _buildLevelItem('Level 3', '10-15% discounts on rental cars', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelItem(String level, String desc, bool unlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: unlocked ? Colors.transparent : Colors.white,
        border: Border.all(color: unlocked ? AppColors.secondaryYellow : AppColors.lightGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: unlocked ? AppColors.secondaryYellow : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(unlocked ? Icons.lock_open : Icons.lock_outline, size: 14, color: unlocked ? Colors.black : AppColors.mediumGrey),
                const SizedBox(width: 6),
                Text(
                  level,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: unlocked ? Colors.black : AppColors.mediumGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              desc,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: unlocked ? Colors.black : AppColors.mediumGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeniusFAQs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text('Genius FAQs', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        _buildFAQItem('How to progress in Genius'),
        _buildFAQItem('Which bookings contribute to my progress in Genius?'),
        _buildFAQItem('Where can I use my Genius discount?'),
        _buildFAQItem('How can I find properties offering rewards?'),
        _buildFAQItem('How are Genius rewards applied?'),
        _buildFAQItem('Why is my Genius level lower than it was before?'),
        _buildFAQItem('I have completed more than 5 bookings, why didn\'t I level up?'),
        _buildFAQItem('Why aren\'t my bookings being counted?'),
        _buildFAQItem('Why am I at a different Genius level on my computer than I am on mobile?'),
        _buildFAQItem('How are my bookings counted?'),
        _buildFAQItem('What rewards do I get at higher levels?'),
        _buildFAQItem('What is my Genius level and why do I have this level?'),
        _buildFAQItem('How does the Genius loyalty programme work?'),
      ],
    );
  }

  Widget _buildFAQItem(String question) {
    return Column(
      children: [
        ExpansionTile(
          title: Text(question, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400)),
          trailing: const Icon(Icons.keyboard_arrow_down, color: AppColors.darkGrey),
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'This information is managed by the Genius loyalty programme to help you track your progress and rewards.',
                style: TextStyle(color: AppColors.darkGrey, fontSize: 14),
              ),
            )
          ],
        ),
        const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.lightGrey),
      ],
    );
  }

  Widget _buildSurveyCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('How are we doing?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Icon(Icons.person, color: Colors.blue, size: 40)),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1 of 2', style: TextStyle(color: AppColors.mediumGrey, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('The Genius programme is relevant to me', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) => Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mediumGrey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('${index + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))),
              )),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Strongly disagree', style: TextStyle(fontSize: 12, color: AppColors.mediumGrey)),
                Text('Strongly agree', style: TextStyle(fontSize: 12, color: AppColors.mediumGrey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
