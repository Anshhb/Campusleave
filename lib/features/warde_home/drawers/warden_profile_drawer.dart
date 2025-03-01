// // import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/theme/pallerte.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// class WardenProfileDrawer extends ConsumerWidget {
//   const WardenProfileDrawer({super.key});
//   void logOut(WidgetRef ref, BuildContext context) {
//     ref.read(authControllerProvider.notifier).logout(ref, context);
//   }

//   void navigateToProfile(BuildContext context, String uid) {
//     Routemaster.of(context).push('/u/$uid');
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider)!;
//     return  Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(user.profilePic),
//               radius: 70,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               user.name,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//             ListTile(
//               title: const Text('My Profile'),
//               leading:  const Icon(Icons.person),
//               onTap: () => navigateToProfile(context, user.uid),
//             ),
//             ListTile(
//               title: const Text('Log Out'),
//               leading: Icon(
//                 Icons.logout,
//                 color: Pallete.redColor,
//               ),
//               onTap: () => logOut(ref, context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// updated

// import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';

class WardenProfileDrawer extends ConsumerWidget {
  const WardenProfileDrawer({super.key});
  void logOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).logout(ref, context);
  }

  void navigateToProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                    radius: 60,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            ListTile(
              title: Text(
                'My Profile',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              leading: const Icon(Icons.person, color: Colors.blueAccent),
              onTap: () => navigateToProfile(context, user.uid),
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              onTap: () => logOut(ref, context),
            ),
          ],
        ),
      ),
    );
  }
}
