import 'package:campusleave/features/warde_home/screens/warden_approved_mail_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_declined_mail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WardenListDrawer extends ConsumerWidget {
  const WardenListDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.start),
            ),
          ),
          ListTile(
            title: const Text('Approved Mails'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WardenApprovedMailScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Declined Mails'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WardenDeclinedMailScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
