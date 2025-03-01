// import 'package:campusleave/features/warde_home/screens/warden_approved_mail_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_declined_mail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WardenListDrawer extends ConsumerWidget {
//   const WardenListDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Padding(
//               padding: EdgeInsets.only(top: 100),
//               child: Text('Menu',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                   textAlign: TextAlign.start),
//             ),
//           ),
//           ListTile(
//             title: const Text('Approved Mails'),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => const WardenApprovedMailScreen(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text('Declined Mails'),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => const WardenDeclinedMailScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// updated

import 'package:campusleave/features/warde_home/screens/warden_approved_mail_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_declined_mail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WardenListDrawer extends ConsumerWidget {
  const WardenListDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.blueAccent),
            title: const Text('Approved Mails',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WardenApprovedMailScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel, color: Colors.redAccent),
            title: const Text('Declined Mails',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
