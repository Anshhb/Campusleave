// import 'package:campusleave/features/home/screens/home_screen.dart';
// import 'package:campusleave/features/auth/screens/login_screen.dart';
// import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
// import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart';

// final loggedOutRoute = RouteMap(routes: {
//   '/' : (_) => const MaterialPage(child: LoginScreen()),
// });

// final loggedInRoute = RouteMap(routes: {
//   '/' : (_) => const MaterialPage(child: HomeScreen()),
//   '/u/:uid': (routeData) => MaterialPage(
//         child: ProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ), // Add this route
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: EditProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

//2nd

// import 'package:campusleave/features/auth/user_auth/screens/login_page.dart';
// import 'package:campusleave/features/auth/user_auth/screens/sign_up_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_edit_user_profile.dart';
// import 'package:campusleave/features/faculty/screens/faculty_profile_screen.dart';
// import 'package:campusleave/features/home/screens/home_screen.dart';
// import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
// import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_home_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_edit_profile_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart'; // Import Routemaster library

// final loggedOutRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: LoginPage()),
//   '/signup': (_) => const MaterialPage(child: SignUpPage()), // Add this route
// });

// final loggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: HomeScreen()),
//   '/u/:uid': (routeData) => MaterialPage(
//         child: ProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: EditProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

// final facultyLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: FacultyHomeScreen()),
//   // Add other faculty-specific routes here if needed
//   '/u/:uid': (routeData) => MaterialPage(
//         child: FacultyProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: FacultyEditUserProfile(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });
// final wardenLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: WardenHomeScreen()),
//   // Add other warden-specific routes here if needed
//   '/u/:uid': (routeData) => MaterialPage(
//         child: FacultyProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: WardenEditProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

// main logic

// import 'package:campusleave/features/auth/user_auth/screens/login_page.dart';
// import 'package:campusleave/features/auth/user_auth/screens/sign_up_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_edit_user_profile.dart';
// import 'package:campusleave/features/faculty/screens/faculty_profile_screen.dart';
// import 'package:campusleave/features/home/screens/home_screen.dart';
// import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
// import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_home_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_edit_profile_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart'; // Import Routemaster library

// /// Define routes for users who are logged out
// final loggedOutRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: LoginPage()), // Login Page
//   '/signup': (_) => const MaterialPage(child: SignUpPage()), // Sign-Up Page
// });

// /// Define routes for students
// final studentLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: HomeScreen()), // Student Home Screen
//   '/u/:uid': (routeData) => MaterialPage(
//         child: ProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: EditProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

// /// Define routes for faculty
// final facultyLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: FacultyHomeScreen()), // Faculty Home Screen
//   '/u/:uid': (routeData) => MaterialPage(
//         child: FacultyProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: FacultyEditUserProfile(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

// /// Define routes for warden
// final wardenLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: WardenHomeScreen()), // Warden Home Screen
//   '/u/:uid': (routeData) => MaterialPage(
//         child: FacultyProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
//   '/edit-profile/:uid': (routeData) => MaterialPage(
//         child: WardenEditProfileScreen(
//           uid: routeData.pathParameters['uid']!,
//         ),
//       ),
// });

// /// Decide which route to use based on the user's role
// RouteMap getRouteBasedOnRole(String role) {
//   switch (role.toLowerCase()) {
//     case 'student':
//       return studentLoggedInRoute;
//     case 'faculty':
//       return facultyLoggedInRoute;
//     case 'warden':
//       return wardenLoggedInRoute;
//     default:
//       throw Exception('Unknown role: $role');
//   }
// }

// import 'package:campusleave/features/auth/user_auth/screens/login_page.dart';
// import 'package:campusleave/features/auth/user_auth/screens/sign_up_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_edit_user_profile.dart';
// import 'package:campusleave/features/faculty/screens/faculty_profile_screen.dart';
// import 'package:campusleave/features/home/screens/home_screen.dart';
// import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
// import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
// import 'package:campusleave/features/faculty/screens/faculty_home_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_edit_profile_screen.dart';
// import 'package:campusleave/features/warde_home/screens/warden_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart';

// /// Define routes for users who are logged out
// final loggedOutRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: LoginPage()), // Login Page
//   '/signup': (_) => const MaterialPage(child: SignUpPage()), // Sign-Up Page
// });

// // /// Define routes for students
// // final studentLoggedInRoute = RouteMap(routes: {
// //   '/': (_) => const MaterialPage(child: HomeScreen()), // Student Home Screen
// // });

// // /// Define routes for faculty
// // final facultyLoggedInRoute = RouteMap(routes: {
// //   '/': (_) => const MaterialPage(child: FacultyHomeScreen()), // Faculty Home Screen
// // });

// /// Define routes for warden
// final wardenLoggedInRoute = RouteMap(routes: {
//   '/': (_) => const MaterialPage(child: WardenHomeScreen()), // Warden Home Screen
// });

// /// Decide which route to use based on the user's role
// RouteMap getRouteBasedOnRole(String role) {
//   switch (role.toLowerCase()) {
//     case 'student':
//       return studentLoggedInRoute;
//     case 'faculty':
//       return facultyLoggedInRoute;
//     case 'warden':
//       return wardenLoggedInRoute;
//     default:
//       throw Exception('Unknown role: $role');
//   }
// }

// String? getRouteNameBasedOnRole(String role) {
//   switch (role.toLowerCase()) {
//     case 'student':
//       return '/student-dashboard'; // Replace with your student route name
//     case 'faculty':
//       return '/faculty-dashboard'; // Replace with your faculty route name
//     case 'warden':
//       return '/warden-dashboard'; // Replace with your warden route name
//     default:
//       return null; // Invalid role
//   }
// }
// final RouteMap studentLoggedInRoute = RouteMap(routes: {
//   '/student-dashboard': (context) => const MaterialPage(child: HomeScreen()),
// });

// final RouteMap facultyLoggedInRoute = RouteMap(routes: {
//   '/faculty-dashboard': (context) => const MaterialPage(child: FacultyHomeScreen()),
// });

// final RouteMap wardenLoggedInRoute = RouteMap(routes: {
//   '/warden-dashboard': (context) => const MaterialPage(child: WardenHomeScreen()),
// });

// import 'package:campusleave/features/auth/screens/login_screen.dart';
import 'package:campusleave/features/user_auth/screens/login_page.dart';
import 'package:campusleave/features/user_auth/screens/sign_up_screen.dart';
import 'package:campusleave/features/faculty/screens/faculty_edit_user_profile.dart';
import 'package:campusleave/features/faculty/screens/faculty_profile_screen.dart';
import 'package:campusleave/features/home/screens/home_screen.dart';
import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
import 'package:campusleave/features/faculty/screens/faculty_home_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_edit_profile_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_home_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

/// Define routes for users who are logged out
final loggedOutRoute = RouteMap(routes: {
  '/': (_) => MaterialPage(child: LoginPage()),
  '/signup': (_) => const MaterialPage(child: SignUpPage()),
  '/login': (_) => MaterialPage(child: LoginPage())
});

/// Define routes for students
final studentLoggedInRoute = RouteMap(routes: {
  '/login': (_) => MaterialPage(child: LoginPage()),
  '/signup': (_) => const MaterialPage(child: SignUpPage()),
  // '/student-home': (_) => const MaterialPage(child: HomeScreen()),
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/u/:uid': (routeData) => MaterialPage(
        child: ProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});

/// Define routes for faculty
final facultyLoggedInRoute = RouteMap(routes: {
  '/login': (_) => MaterialPage(child: LoginPage()),
  '/signup': (_) => const MaterialPage(child: SignUpPage()),
  // '/faculty-home': (_) => const MaterialPage(child: FacultyHomeScreen()),
  '/': (_) => const MaterialPage(child: FacultyHomeScreen()),
  '/u/:uid': (routeData) => MaterialPage(
        child: FacultyProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: FacultyEditUserProfile(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});

/// Define routes for wardens
final wardenLoggedInRoute = RouteMap(routes: {
  '/login': (_) => MaterialPage(child: LoginPage()),
  '/signup': (_) => const MaterialPage(child: SignUpPage()),
  // '/warden-home': (_) => const MaterialPage(child: WardenHomeScreen()),
  '/': (_) => const MaterialPage(child: WardenHomeScreen()),
  '/u/:uid': (routeData) => MaterialPage(
        child: WardenProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: WardenEditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});
