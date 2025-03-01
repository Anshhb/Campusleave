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

//   void navigateToWardenEmail(BuildContext context) async {
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
//               onPressed: () => navigateToWardenEmail(context),
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

// import 'package:campusleave/features/auth/user_auth/user_controller/user_auth_controller.dart';
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

//   void navigateToWardenEmail(BuildContext context) async {
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
//                   color: Color.fromARGB(255, 46, 32, 32),
//                   fontFamily: 'CustomFont4'
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => navigateToFacultySelection(context),
//               icon: const Icon(Icons.email, color: Colors.white),
//               label: const Text(
//                 'Send Email To Faculty Advisor',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
//               onPressed: () => navigateToWardenEmail(context),
//               icon: const Icon(Icons.school, color: Colors.white),
//               label: const Text(
//                 'Send Email To Warden',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
//                     builder: (context) => const EmailToMessPage(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.food_bank, color: Colors.white),
//               label: const Text(
//                 'Send Email To Mess IITJ',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
// import 'package:campusleave/features/auth/user_auth/user_controller/user_auth_controller.dart';
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

//   void navigateToWardenEmail(BuildContext context) async {
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
//                   color: Color.fromARGB(255, 46, 32, 32),
//                   fontFamily: 'CustomFont4'
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => navigateToFacultySelection(context),
//               icon: const Icon(Icons.email, color: Colors.white),
//               label: const Text(
//                 'Send Email To Faculty Advisor',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
//               onPressed: () => navigateToWardenEmail(context),
//               icon: const Icon(Icons.school, color: Colors.white),
//               label: const Text(
//                 'Send Email To Warden',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
//                     builder: (context) => const EmailToMessPage(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.food_bank, color: Colors.white),
//               label: const Text(
//                 'Send Email To Mess IITJ',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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

// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/email/screens/send_email.dart';
// import 'package:campusleave/features/home/drawers/profile_drawer.dart';
// import 'package:campusleave/features/home/drawers/recent_activity_drawer.dart';
// import 'package:campusleave/features/mess/screens/email_mess.dart';
// import 'package:campusleave/features/warden/screens/warden_email.dart';
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

//   void navigateToFacultyEmail(BuildContext context, WidgetRef ref) {
//     // final user = ref.watch(userProvider)!;
//     // final facultyAdvisorEmail = user.faEmail; // Assuming it's stored in the user model
//     // final facultyAdvisor = SendEmailScreen(advisor: facultyAdvisorEmail);

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => const SendEmailScreen(),
//       ),
//     );
//   }

//   void navigateToWardenEmail(BuildContext context, WidgetRef ref) async {
//     // final user = ref.watch(userProvider)!;
//     // final wardenEmail = user.wardenEmail;
//     // final warden = await Navigator.of(context).push<WardenModel?>(
//     //   MaterialPageRoute(
//     //     builder: (context) => const WardenSelectionScreen(),
//     //   ),
//     // );

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => const EmailToWardenPage(),
//       ),
//     );
//   }

//   void navigateToMessEmail(BuildContext context, WidgetRef ref) async {
//     // final user = ref.watch(userProvider)!;
//     // final wardenEmail = user.wardenEmail;
//     // final warden = await Navigator.of(context).push<WardenModel?>(
//     //   MaterialPageRoute(
//     //     builder: (context) => const WardenSelectionScreen(),
//     //   ),
//     // );

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => const EmailToMessPage(),
//       ),
//     );
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
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900,
//                     color: Color.fromARGB(255, 46, 32, 32),
//                     fontFamily: 'CustomFont4'),
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () => navigateToFacultyEmail(context, ref),
//               icon: const Icon(Icons.email, color: Colors.white),
//               label: const Text(
//                 'Send Email To Faculty Advisor',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
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
//               onPressed: () => navigateToWardenEmail(context, ref),
//               icon: const Icon(Icons.school, color: Colors.white),
//               label: const Text(
//                 'Send Email To Warden',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 minimumSize: const Size(double.infinity, 60),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Colors.green,
//                 elevation: 5,
//                 shadowColor: Colors.greenAccent,
//               ),
//             ),
//             // const SizedBox(height: 20),
//             // ElevatedButton.icon(
//             //   onPressed: () => navigateToMessEmail(context, ref),
//             //   icon: const Icon(Icons.food_bank, color: Colors.white),
//             //   label: const Text(
//             //     'Send Email To Mess IITJ',
//             //     style: TextStyle(color: Colors.white, fontSize: 18),
//             //   ),
//             //   style: ElevatedButton.styleFrom(
//             //     padding: const EdgeInsets.symmetric(vertical: 18.0),
//             //     minimumSize: const Size(double.infinity, 60),
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(20),
//             //     ),
//             //     backgroundColor: Colors.orange,
//             //     elevation: 5,
//             //     shadowColor: Colors.orangeAccent,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// new updated

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
