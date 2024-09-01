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

import 'package:campusleave/features/faculty/screens/faculty_edit_user_profile.dart';
import 'package:campusleave/features/faculty/screens/faculty_profile_screen.dart';
import 'package:campusleave/features/home/screens/home_screen.dart';
import 'package:campusleave/features/auth/screens/login_screen.dart';
import 'package:campusleave/features/user_profile/screens/edit_profile_screen.dart';
import 'package:campusleave/features/user_profile/screens/user_profile_screen.dart';
import 'package:campusleave/features/faculty/screens/faculty_home_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_edit_profile_screen.dart';
import 'package:campusleave/features/warde_home/screens/warden_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart'; // Import Routemaster library

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
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

final facultyLoggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: FacultyHomeScreen()),
  // Add other faculty-specific routes here if needed
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
final wardenLoggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: WardenHomeScreen()),
  // Add other warden-specific routes here if needed
  '/u/:uid': (routeData) => MaterialPage(
        child: FacultyProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: WardenEditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});
