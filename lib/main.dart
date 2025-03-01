// import 'package:campusleave/core/common/error_text.dart';
// import 'package:campusleave/core/common/loader.dart';
// import 'package:campusleave/features/auth/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/firebase_options.dart';
// import 'package:campusleave/models/user_model.dart';
// import 'package:campusleave/router.dart';
// import 'package:campusleave/theme/pallerte.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   UserModel? userModel;

//   void getData(WidgetRef ref, User data) async {
//     userModel = await ref
//         .watch(authControllerProvider.notifier)
//         .getUserdata(data.uid)
//         .first;
//     ref.read(userProvider.notifier).update((state) => userModel);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(authStateChangeProvider).when(
//           data: (data) => MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'campusleave',
//             theme: Pallete.lightModeAppTheme,
//             routerDelegate: RoutemasterDelegate(
//               routesBuilder: (context) {
//                 if (data != null) {
//                   getData(ref, data);
//                   if (userModel != null) {
//                     if (userModel!.role == 'faculty') {
//                       return facultyLoggedInRoute;
//                     }
//                     else if (userModel!.role == 'warden') {
//                       return wardenLoggedInRoute;
//                     }
//                      else {
//                       return studentLoggedInRoute;
//                     }
//                   }
//                 }
//                 return loggedOutRoute;
//               },
//             ),
//             routeInformationParser: const RoutemasterParser(),
//           ),
//           error: (error, stackTrace) => ErrorText(error: error.toString()),
//           loading: () => const Loader(),
//         );
//   }
// }

// import 'package:campusleave/core/common/error_text.dart';
// import 'package:campusleave/core/common/loader.dart';
// import 'package:campusleave/features/auth/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/firebase_options.dart';
// import 'package:campusleave/models/user_model.dart';
// import 'package:campusleave/router.dart';
// import 'package:campusleave/theme/pallerte.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   UserModel? userModel;

//   Future<void> getData(WidgetRef ref, User data) async {
//     userModel = await ref
//         .watch(authControllerProvider.notifier)
//         .getUserData(data.uid)
//         .first;
//     ref.read(userProvider.notifier).update((state) => userModel);
//     // setState(() {});
//   // if (userModel != null) {
//   //   ref.read(userProvider.notifier).update((state) => userModel);
//   //   setState(() {});  // Ensure UI updates with new data
//   // }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(authStateChangeProvider).when(
//           data: (data) => MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'CampusLeave',
//             theme: Pallete.lightModeAppTheme,
//             routerDelegate: RoutemasterDelegate(
//               routesBuilder: (context) {
//                 if (data != null) {
//                   getData(ref, data);
//                   print("role of user: ");
//                   print(userModel?.role);
//                   // if (userModel == null) {
//                   //   getData(ref, data);
//                   //   print(userModel?.role);
//                   // }

//                   // Determine route map based on user role
//                   if (userModel != null) {
//                     switch (userModel!.role) {
//                       case 'faculty':
//                         return facultyLoggedInRoute;
//                       case 'warden':
//                         return wardenLoggedInRoute;
//                       default:
//                         return studentLoggedInRoute;
//                     }
//                   }
//                 }
//                 return loggedOutRoute;
//               },
//             ),
//             routeInformationParser: const RoutemasterParser(),
//           ),
//           error: (error, stackTrace) => ErrorText(error: error.toString()),
//           loading: () => const Loader(),
//         );
//   }
// }

import 'package:campusleave/core/common/error_text.dart';
import 'package:campusleave/core/common/loader.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/firebase_options.dart';
import 'package:campusleave/models/user_model.dart';
import 'package:campusleave/router.dart';
import 'package:campusleave/theme/pallerte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  bool isLoading = true;

  // Future<void> getData(WidgetRef ref, User data) async {
  //   userModel = await ref
  //       .read(authControllerProvider.notifier)
  //       .getUserData(data.uid)
  //       .first;

  //   ref.read(userProvider.notifier).update((state) => userModel);
  //   setState(() {
  //     isLoading = false;  // Update state after fetching user data
  //   });
  // }
  void logOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).logout(ref, context);
  }

  Future<void> getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;

    // Ensure userProvider updates correctly
    ref.read(userProvider.notifier).update((state) => userModel);

    // Force rebuild when user changes
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null && userModel == null && isLoading) {
              getData(ref, data); // Ensure userModel is loaded before routing
            }

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'CampusLeave',
              theme: Pallete.lightModeAppTheme,
              // routerDelegate: RoutemasterDelegate(
              //   routesBuilder: (context) {
              //     if (data == null) {
              //       return loggedOutRoute;  // If not logged in, go to login/signup
              //     }

              //     if (isLoading || userModel == null) {
              //       return RouteMap(routes: {
              //         '/': (_) => const MaterialPage(child: Loader()), // Show loader while fetching user data
              //       });
              //     }

              //     // Determine correct route after user data is loaded
              //     switch (userModel!.role) {
              //       case 'faculty':
              //         return facultyLoggedInRoute;
              //       case 'warden':
              //         return wardenLoggedInRoute;
              //       default:
              //         return studentLoggedInRoute;
              //     }
              //   },
              // ),
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (data != null) {
                    // print('usermodel role: ${userModel?.role}');
                    return userModel != null
                        ? (userModel!.role == 'faculty'
                            ? facultyLoggedInRoute
                            : userModel!.role == 'warden'
                                ? wardenLoggedInRoute
                                : studentLoggedInRoute)
                        : loggedOutRoute;
                  }
                  userModel = null;
                  return loggedOutRoute;
                },
              ),

              routeInformationParser: const RoutemasterParser(),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
