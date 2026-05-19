import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../core/theme/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              color: AppColors.primaryBlue,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 32, top: 16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35, // Reduced from 40
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 45, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Sign in to manage your trip and save 10% or more on select stays and rental cars',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 280, // Reduced from 300
                    height: 44, // Reduced from 50
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Sign in or register', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Menu Items
            _buildSection([
              _buildMenuItem(Icons.gesture, 'Genius loyalty programme'),
              _buildMenuItem(Icons.wallet, 'Rewards & Wallet'),
              _buildMenuItem(Icons.settings_outlined, 'Device preferences'),
            ]),
            
            const SizedBox(height: 24),
            
            _buildHeader('Help and support'),
            _buildSection([
              _buildMenuItem(Icons.help_outline, 'Contact Customer service'),
              _buildMenuItem(Icons.support, 'Safety resource centre'),
              _buildMenuItem(Icons.handshake_outlined, 'Dispute resolution'),
            ]),
            
            const SizedBox(height: 24),
            
            _buildHeader('Travel activity'),
            _buildSection([
              _buildMenuItem(Icons.article_outlined, 'Travel articles'),
              _buildMenuItem(Icons.question_answer_outlined, 'My questions to properties'),
            ]),
            
            const SizedBox(height: 24),
            
            _buildHeader('Discover'),
            _buildSection([
              _buildMenuItem(Icons.percent_outlined, 'Deals'),
            ]),
            
            const SizedBox(height: 24),
            
            _buildHeader('Legal and privacy'),
            _buildSection([
              _buildMenuItem(Icons.edit_note_outlined, 'Content guidelines'),
            ]),
            
            const SizedBox(height: 24),
            
            _buildHeader('Manage your property'),
            _buildSection([
              _buildMenuItem(Icons.add_home_work_outlined, 'List your property'),
            ]),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    bool showDivider = title != 'Device preferences' && 
                      title != 'Dispute resolution' && 
                      title != 'My questions to properties' &&
                      title != 'Deals' &&
                      title != 'Content guidelines' &&
                      title != 'List your property';
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.darkGrey),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right, color: AppColors.mediumGrey),
          onTap: () {
            if (title == 'Genius loyalty programme') {
              Get.toNamed('/genius');
            }
          },
        ),
        if (showDivider)
          const Divider(height: 1, indent: 56),
      ],
    );
  }
}
