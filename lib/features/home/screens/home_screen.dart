// import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/email/screens/faculty_email.dart';
// import 'package:campusleave/features/email/screens/faculty_selection_screen.dart';
// import 'package:campusleave/features/home/drawers/profile_drawer.dart';
// import 'package:campusleave/features/home/drawers/recent_activity_drawer.dart';
// import 'package:campusleave/features/mess/screens/email_mess.dart';
// import 'package:campusleave/features/warden/screens/warden_email.dart';
// import 'package:campusleave/features/warden/screens/warden_selection_screen.dart';
// import 'package:campusleave/models/faculty_advisor_model.dart';
// import 'package:campusleave/models/warden_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   void displayDrawer(BuildContext context) {
//     Scaffold.of(context).openDrawer();
//   }

//   void displayEndDrawer(BuildContext context) {
//     Scaffold.of(context).openEndDrawer();
//   }

//   void navigateToFacultySelection(BuildContext context) async {
//     final advisor = await Navigator.of(context).push<FacultyAdvisor?>(
//       MaterialPageRoute(
//         builder: (context) => const FacultySelectionScreen(),
//       ),
//     );
//     if (advisor != null) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => EmailToFacultyPage(advisor: advisor),
//         ),
//       );
//     }
//   }

//   void navigateToWardenSelection(BuildContext context) async {
//     final warden = await Navigator.of(context).push<WardenModel?>(
//       MaterialPageRoute(
//         builder: (context) => const WardenSelectionScreen(),
//       ),
//     );
//     if (warden != null) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => EmailToWardenPage(warden: warden),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider)!;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Home',
//         ),
//         centerTitle: false,
//         leading: Builder(builder: (context) {
//           return IconButton(
//             onPressed: () => displayDrawer(context),
//             icon: const Icon(Icons.menu),
//           );
//         }),
//         actions: [
//           Builder(builder: (context) {
//             return IconButton(
//               icon: CircleAvatar(
//                 backgroundImage: NetworkImage(user.profilePic),
//               ),
//               onPressed: () => displayEndDrawer(context),
//             );
//           })
//         ],
//       ),
//       drawer: const RecentActivityDrawer(),
//       endDrawer: const ProfileDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 40.0),
//               child: Text(
//                 'Approve Your Leave Application',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w900,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => navigateToFacultySelection(context),
//               icon: const Icon(Icons.email, color: Colors.white),
//               label: const Text(
//                 'Send Email To Faculty Advisor',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Colors.blue,
//                 elevation: 5,
//                 shadowColor: Colors.blueAccent,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => navigateToWardenSelection(context),
//               icon: const Icon(Icons.school, color: Colors.white),
//               label: const Text(
//                 'Send Email To Warden',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Colors.green,
//                 elevation: 5,
//                 shadowColor: Colors.greenAccent,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const EmailToMessPage()),
//                 );
//               },
//               icon: const Icon(Icons.food_bank, color: Colors.white),
//               label: const Text(
//                 'Send Email To Mess IITJ',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Colors.orange,
//                 elevation: 5,
//                 shadowColor: Colors.orangeAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/features/email/screens/faculty_email.dart';
import 'package:campusleave/features/email/screens/faculty_selection_screen.dart';
import 'package:campusleave/features/home/drawers/profile_drawer.dart';
import 'package:campusleave/features/home/drawers/recent_activity_drawer.dart';
import 'package:campusleave/features/mess/screens/email_mess.dart';
import 'package:campusleave/features/warden/screens/warden_email.dart';
import 'package:campusleave/features/warden/screens/warden_selection_screen.dart';
import 'package:campusleave/models/faculty_advisor_model.dart';
import 'package:campusleave/models/warden_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void navigateToFacultySelection(BuildContext context) async {
    final advisor = await Navigator.of(context).push<FacultyAdvisor?>(
      MaterialPageRoute(
        builder: (context) => const FacultySelectionScreen(),
      ),
    );
    if (advisor != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EmailToFacultyPage(advisor: advisor),
        ),
      );
    }
  }

  void navigateToWardenSelection(BuildContext context) async {
    final warden = await Navigator.of(context).push<WardenModel?>(
      MaterialPageRoute(
        builder: (context) => const WardenSelectionScreen(),
      ),
    );
    if (warden != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EmailToWardenPage(warden: warden),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => displayDrawer(context),
            icon: const Icon(Icons.menu),
          );
        }),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          })
        ],
      ),
      drawer: const RecentActivityDrawer(),
      endDrawer: const ProfileDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                'Approve Your Leave Application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 46, 32, 32),
                  fontFamily: 'CustomFont4'
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => navigateToFacultySelection(context),
              icon: const Icon(Icons.email, color: Colors.white),
              label: const Text(
                'Send Email To Faculty Advisor',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.blue,
                elevation: 5,
                shadowColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => navigateToWardenSelection(context),
              icon: const Icon(Icons.school, color: Colors.white),
              label: const Text(
                'Send Email To Warden',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.green,
                elevation: 5,
                shadowColor: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailToMessPage(),
                  ),
                );
              },
              icon: const Icon(Icons.food_bank, color: Colors.white),
              label: const Text(
                'Send Email To Mess IITJ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.orange,
                elevation: 5,
                shadowColor: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
