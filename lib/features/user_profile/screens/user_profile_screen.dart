import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  void navigateToEditProfile(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 60,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () => navigateToEditProfile(context),
                icon: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  fixedSize: const Size(100, 20)
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(user.email),
            ),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
