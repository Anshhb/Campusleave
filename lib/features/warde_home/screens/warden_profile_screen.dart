// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// class WardenProfileScreen extends ConsumerWidget {
//   final String uid;
//   const WardenProfileScreen({super.key, required this.uid});

//   void navigateToEditProfile(BuildContext context) {
//     Routemaster.of(context).push('/edit-profile/$uid');
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//    final user = ref.watch(userProvider)!;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profilePic),
//                 radius: 60,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 user.name,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Center(
//               child: IconButton(
//                 onPressed: () => navigateToEditProfile(context),
//                 icon: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
//                 style: IconButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   fixedSize: const Size(100, 20)
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider(),
//             ListTile(
//               title: const Text('Email'),
//               subtitle: Text(user.email),
//             ),
//             // Add more user details as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// updated

import 'package:campusleave/core/common/error_text.dart';
import 'package:campusleave/core/common/loader.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';

class WardenProfileScreen extends ConsumerWidget {
  final String uid;
  const WardenProfileScreen({super.key, required this.uid});

  void navigateToEditProfile(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 10,
        shadowColor: Colors.black26,
      ),
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                    radius: 70,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.email,
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: () => navigateToEditProfile(context),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.deepPurpleAccent,
                      elevation: 8,
                      shadowColor: Colors.deepPurpleAccent.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(Icons.mail, color: Colors.deepPurpleAccent),
                    title: const Text('Email'),
                    subtitle: Text(user.email),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
