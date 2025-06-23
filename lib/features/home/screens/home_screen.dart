

import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/features/email/screens/send_email.dart';
import 'package:campusleave/features/home/drawers/profile_drawer.dart';
import 'package:campusleave/features/home/drawers/recent_activity_drawer.dart';
import 'package:campusleave/features/warden/screens/warden_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void navigateToEmail(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        shadowColor: Colors.black26,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => displayDrawer(context),
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            ),
          )
        ],
      ),
      drawer: const RecentActivityDrawer(),
      endDrawer: const ProfileDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                'Manage Your Leave Applications',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildActionButton(
              context,
              icon: Icons.email,
              label: 'Email Faculty Advisor',
              color: Colors.blue,
              onPressed: () =>
                  navigateToEmail(context, const SendEmailScreen()),
            ),
            const SizedBox(height: 25),
            _buildActionButton(
              context,
              icon: Icons.school,
              label: 'Email Warden',
              color: Colors.green,
              onPressed: () =>
                  navigateToEmail(context, const EmailToWardenPage()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: color,
        elevation: 8,
        shadowColor: color.withOpacity(0.5),
      ),
    );
  }
}
