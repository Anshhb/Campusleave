// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:routemaster/routemaster.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isSigning = false;
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _signIn();
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: _isSigning
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _signIn() async {
//     setState(() {
//       _isSigning = true;
//     });

//     String email = _emailController.text;
//     String password = _passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     setState(() {
//       _isSigning = false;
//     });

//     if (user != null) {
//       Fluttertoast.showToast(msg: "User is successfully signed in");
//       // ignore: use_build_context_synchronously
//       Routemaster.of(context).push('/');
//     } else {
//       Fluttertoast.showToast(msg: "some error occured");
//     }
//   }
// }

// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:routemaster/routemaster.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isSigning = false;
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late Map<String, String> _userRoles;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRoles();
//   }

//   Future<void> _loadUserRoles() async {
//     // Load the CSV file from assets and parse it
//     final csvData = await rootBundle.loadString('assets/G5_Hostel_Details.csv');
//     final lines = const LineSplitter().convert(csvData);
//     final roles = <String, String>{};

//     for (var line in lines.skip(1)) {
//       final parts = line.split(',');
//       if (parts.length > 4) {
//         final name = parts[1].trim(); // Assuming email is in the first column
//         final role = parts[11].trim(); // Assuming role is in the third column
//         roles[name] = role.toLowerCase();
//       }
//     }

//     setState(() {
//       _userRoles = roles;
//     });
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _signIn();
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: _isSigning
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// void _signIn() async {
//   setState(() {
//     _isSigning = true;
//   });

//   String email = _emailController.text.trim();
//   String password = _passwordController.text.trim();

//   try {
//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     if (user != null) {
//       Fluttertoast.showToast(msg: "User successfully signed in");

//       // Fetch role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (userDoc.exists) {
//         final role = userDoc['role'] as String;

//         // Navigate based on role
//         switch (role) {
//           case 'student':
//             Routemaster.of(context).replace('/');
//             break;
//           case 'warden':
//             Routemaster.of(context).replace('/');
//             break;
//           default:
//             Fluttertoast.showToast(msg: "Unknown role: $role");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "No role assigned to this user.");
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Invalid credentials.");
//     }
//   } catch (e) {
//     Fluttertoast.showToast(msg: "Error during login: $e");
//   } finally {
//     setState(() {
//       _isSigning = false;
//     });
//   }
// }
// }

//   void _signIn() async {
//     setState(() {
//       _isSigning = true;
//     });

//     String email = _emailController.text;
//     String password = _passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     setState(() {
//       _isSigning = false;
//     });

//     if (user != null) {
//       Fluttertoast.showToast(msg: "User successfully signed in");

//       // Determine the role based on email
//       final role = _userRoles[email.toLowerCase()];

//       if (role != null) {
//         // Navigate to the appropriate home screen
//         switch (role) {
//           case 'student':
//             Routemaster.of(context).replace('/');
//             break;
//           case 'faculty':
//             Routemaster.of(context).replace('/');
//             break;
//           case 'warden':
//             Routemaster.of(context).replace('/');
//             break;
//           default:
//             Fluttertoast.showToast(msg: "Invalid role: $role");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "No role found for the user");
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Error occurred during sign-in");
//     }
//   }
// }

//main logic

// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:routemaster/routemaster.dart';
// import 'package:campusleave/router.dart'; // Import the routing logic

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isSigning = false;
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late Map<String, String> _userRoles;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(height: 10),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: _signIn,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: _isSigning
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _signIn() async {
//   setState(() {
//     _isSigning = true;
//   });

//   String email = _emailController.text.trim();
//   String password = _passwordController.text.trim();

//   try {
//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     if (user != null) {
//       Fluttertoast.showToast(msg: "User successfully signed in");

//       // Fetch role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (userDoc.exists) {
//         final role = userDoc['role'] as String;

//         // Navigate based on role
//         // final routeName = getRouteBasedOnRole(role);
//         if (routeName != null) {
//           Routemaster.of(context).replace(routeName);
//         } else {
//           Fluttertoast.showToast(msg: "Invalid role assigned.");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "No role assigned to this user.");
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Invalid credentials.");
//     }
//   } catch (e) {
//     Fluttertoast.showToast(msg: "Error during login: $e");
//   } finally {
//     setState(() {
//       _isSigning = false;
//     });
//   }
// }

// }

// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:routemaster/routemaster.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isSigning = false;
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(height: 10),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: _signIn,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: _isSigning
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _signIn() async {
//     setState(() {
//       _isSigning = true;
//     });

//   void navigateToHomeScreen(BuildContext context) {
//     Routemaster.of(context).push('/');
//   }

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     try {
//       User? user = await _auth.signInWithEmailAndPassword(email, password);

//       if (user != null) {
//         Fluttertoast.showToast(msg: "User successfully signed in");

//         // // Fetch role from Firestore
//         // DocumentSnapshot userDoc = await FirebaseFirestore.instance
//         //     .collection('users')
//         //     .doc(user.uid)
//         //     .get();

//         // if (userDoc.exists) {
//         //   final role = userDoc['role'] as String;
//         //   // print(role);

//         //   // Navigate based on role
//         //   String? routeName = _getRouteBasedOnRole(role);
//         //   // print(routeName);

//         //   if (routeName != null) {
//         //     Routemaster.of(context).replace(routeName);
//         navigateToHomeScreen(context);
//         }
//       //     } else {
//       //       Fluttertoast.showToast(msg: "Invalid role assigned.");
//       //     }
//       //   } else {
//       //     Fluttertoast.showToast(msg: "No role assigned to this user.");
//       //   }
//       // } else {
//       //   Fluttertoast.showToast(msg: "Invalid credentials.");
//       // }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error during login: $e");
//     } finally {
//       setState(() {
//         _isSigning = false;
//       });
//     }
//   }

// }

// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:routemaster/routemaster.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _isSigning = false;
//   final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(height: 10),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: _signIn,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: _isSigning
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void _signIn() async {
//   //   if (!mounted) return; // Prevent state updates if widget is disposed
//   //   setState(() {
//   //     _isSigning = true;
//   //   });

//   //   String email = _emailController.text.trim();
//   //   String password = _passwordController.text.trim();

//   //   try {
//   //     User? user = await _auth.signInWithEmailAndPassword(email, password);

//   //     if (user != null) {
//   //       Fluttertoast.showToast(msg: "User successfully signed in");

//   //       String? role = await _auth.getUserRole(user.uid);
//   //       if (role == 'student') {
//   //         Routemaster.of(context).replace('/student-home');
//   //       } else if (role == 'faculty') {
//   //         Routemaster.of(context).replace('/faculty-home');
//   //       } else if (role == 'warden') {
//   //         Routemaster.of(context).replace('/warden-home');
//   //       } else {
//   //         Fluttertoast.showToast(msg: "Unauthorized role!");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     Fluttertoast.showToast(msg: "Error during login: $e");
//   //   } finally {
//   //     setState(() {
//   //       _isSigning = false;
//   //     });
//   //   }
//   // }

//   void _signIn() async {
//     if (!mounted) return; // Prevent state updates if widget is disposed

//     setState(() {
//       _isSigning = true;
//     });

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     try {
//       User? user = await _auth.signInWithEmailAndPassword(email, password);

//       if (user != null) {
//         Fluttertoast.showToast(msg: "User successfully signed in");

//         // Fetch user role and navigate accordingly
//         String? role = await _auth.getUserRole(user.uid);
//         print("role: $role");
//         if (!mounted) return; // Check again before calling setState

//         if (role == 'student') {
//           Routemaster.of(context).replace('/student-home');
//         } else if (role == 'faculty') {
//           Routemaster.of(context).replace('/faculty-home');
//         } else if (role == 'warden') {
//           Routemaster.of(context).replace('/warden-home');
//         } else {
//           Fluttertoast.showToast(msg: "Unauthorized role!");
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         Fluttertoast.showToast(msg: "Error during login: $e");
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isSigning = false;
//         });
//       }
//     }
//   }

// }

// import 'package:campusleave/core/utils/utils.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// class LoginPage extends ConsumerWidget {
//   LoginPage({super.key});

//   // @override
//   // State<LoginPage> createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final bool _isSigning = false;
//   // final FirebaseAuthServices _auth = FirebaseAuthServices();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // @override
//   // void dispose() {
//   //   _emailController.dispose();
//   //   _passwordController.dispose();
//   //   // super.dispose();
//   // }

//   // void login(WidgetRef ref, BuildContext context){
//   //   ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim(), context: context);
//   // }

//   void login(WidgetRef ref, BuildContext context) {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       showSnackBar(context, "Please enter email and password.");
//       return;
//     }

//     ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
//           email: email,
//           password: password,
//           context: context,
//         );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               FormContainerWidget(
//                 controller: _emailController,
//                 hintText: "Email",
//                 isPasswordField: false,
//               ),
//               const SizedBox(height: 10),
//               FormContainerWidget(
//                 controller: _passwordController,
//                 hintText: "Password",
//                 isPasswordField: true,
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () {
//                   login(ref, context);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Center(
//                     // child: _isSigning
//                     //     ? const CircularProgressIndicator(color: Colors.white)
//                     //     : const Text(
//                     child: Text(
//                       "Login",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account?"),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Routemaster.of(context).push('/signup');
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// updated

// import 'package:campusleave/core/utils/utils.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// class LoginPage extends ConsumerWidget {
//   LoginPage({super.key});

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void login(WidgetRef ref, BuildContext context) {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       showSnackBar(context, "Please enter email and password.");
//       return;
//     }

//     ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
//           email: email,
//           password: password,
//           context: context,
//         );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blueAccent, Colors.lightBlue],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Center(
//             child: Card(
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     FormContainerWidget(
//                       controller: _emailController,
//                       hintText: "Email",
//                       isPasswordField: false,
//                     ),
//                     const SizedBox(height: 10),
//                     FormContainerWidget(
//                       controller: _passwordController,
//                       hintText: "Password",
//                       isPasswordField: true,
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () => login(ref, context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         minimumSize: const Size(double.infinity, 45),
//                       ),
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account?"),
//                         TextButton(
//                           onPressed: () {
//                             Routemaster.of(context).push('/signup');
//                           },
//                           child: const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:campusleave/core/utils/utils.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(WidgetRef ref, BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, "Please enter email and password.");
      return;
    }

    ref.read(authControllerProvider.notifier).loginWithEmailAndPassword(
          email: email,
          password: password,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/mail.png', // Ensure you have a logo at this path
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome to Campusleave",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContainerWidget(
                      controller: _emailController,
                      hintText: "Email",
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),
                    FormContainerWidget(
                      controller: _passwordController,
                      hintText: "Password",
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => login(ref, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Routemaster.of(context).push('/signup');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
