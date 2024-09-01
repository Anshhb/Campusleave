// import 'package:campusleave/core/common/loader.dart';
// import 'package:campusleave/core/common/sign_in_button.dart';
// import 'package:campusleave/core/constants/constants.dart';
// import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isLoading = ref.watch(authControllerProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Image.asset(
//             Constants.logopath,
//             height: 50,
//             width: 80,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: Text(
//               'IIT JODHPUR',
//               style: TextStyle(
//                 fontWeight: FontWeight.w900,
//                 fontSize: 24,
//                 color: Colors.black87,
//                 fontFamily: 'CustomFont3',
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Loader()
//           : Stack(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xff6DD5FA), Color(0xff2980B9)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'Welcome To!',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 48,
//                           fontWeight: FontWeight.w900,
//                           color: Colors.white,
//                           fontFamily: 'CustomFont3',
//                           shadows: [
//                             Shadow(
//                               blurRadius: 10.0,
//                               color: Colors.black26,
//                               offset: Offset(3.0, 3.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'CampusLeave',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 36,
//                           fontWeight: FontWeight.w900,
//                           color: Colors.white,
//                           fontFamily: 'CustomFont3',
//                           shadows: [
//                             Shadow(
//                               blurRadius: 10.0,
//                               color: Colors.black26,
//                               offset: Offset(3.0, 3.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       Image.asset(
//                         Constants.mailPath,
//                         alignment: Alignment.center,
//                         width: 150,
//                       ),
//                       const SizedBox(height: 40),
//                       const SignInButton(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }



import 'package:campusleave/core/common/loader.dart';
import 'package:campusleave/core/common/sign_in_button.dart';
import 'package:campusleave/core/constants/constants.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            Constants.logopath,
            height: 50,
            width: 80,
            color: Colors.white, // Set the logo color to white for contrast
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              'IIT JODHPUR',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'CustomFont3',
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff6DD5FA), Color(0xff2980B9)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Welcome To!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'CustomFont3',
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black26,
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'CampusLeave',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'CustomFont3',
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black26,
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Image.asset(
                        Constants.mailPath,
                        alignment: Alignment.center,
                        width: 150,
                        color: Colors.white, // Set the logo color to white for contrast
                      ),
                      const SizedBox(height: 40),
                      const SignInButton(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
