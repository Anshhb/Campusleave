import 'package:campusleave/features/faculty/screens/approved_mails.dart';
import 'package:campusleave/features/faculty/screens/declined_mails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDrawer extends ConsumerWidget {
  const ListDrawer({super.key});

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
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24),textAlign: TextAlign.start),
              ),
            ),
            ListTile(
              title: const Text('Approved Mails'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ApprovedMailsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Declined Mails'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const DeclinedMailsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
  }
}