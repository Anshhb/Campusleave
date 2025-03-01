// import 'dart:convert';
// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:routemaster/routemaster.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuthServices _auth = FirebaseAuthServices();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();

//   bool isSigningUp = false;
//   String? userType;
//   Map<String, String> validStudents = {};
//   List<String> wardenEmails = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCsvData();
//   }

//   Future<void> _loadCsvData() async {
//     try {
//       final csvContent =
//           await rootBundle.loadString('assets/G5_Hostel_Details.csv');
//       final lines = const LineSplitter().convert(csvContent);

//       for (var line in lines.skip(1)) {
//         final columns = line.split(',');
//         print(columns[11].trim().toUpperCase());
//         if (columns.length >= 4) {
//           if (columns[11].trim().toUpperCase() == 'STUDENT') {
//             validStudents[columns[3].trim()] =
//                 columns[1].trim(); // Roll No -> Name
//           } else if (columns[11].trim().toUpperCase() == 'WARDEN') {
//             wardenEmails.add(columns[1].trim());
//           }
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error loading CSV data: $e");
//     }
//   }

//   Future<bool> isValidRollNumber(String rollNumber) async {
//     return validStudents.containsKey(rollNumber.trim());
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _rollNumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("SignUp"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: userType,
//                 hint: const Text("Select User Type"),
//                 items: const [
//                   DropdownMenuItem(value: "Student", child: Text("Student")),
//                   DropdownMenuItem(value: "Warden", child: Text("Warden")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     userType = value;
//                   });
//                 },
//               ),
//               if (userType == "Student") ...[
//                 const SizedBox(height: 10),
//                 FormContainerWidget(
//                   controller: _rollNumberController,
//                   hintText: "Roll Number",
//                   isPasswordField: false,
//                 ),
//               ],
//               const SizedBox(height: 10),
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
//                 onTap: _signUp,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: isSigningUp
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// Future<void> _signUp() async {
//   if (userType == null) {
//     Fluttertoast.showToast(msg: "Please select a user type.");
//     return;
//   }

//   setState(() {
//     isSigningUp = true;
//   });

//   String email = _emailController.text.trim();
//   String password = _passwordController.text.trim();
//   String rollNumber = _rollNumberController.text.trim();

//   if (userType == "Student") {
//     bool isValid = await isValidRollNumber(rollNumber);
//     if (!isValid) {
//       Fluttertoast.showToast(msg: "Invalid Roll Number.");
//       setState(() {
//         isSigningUp = false;
//       });
//       return;
//     }
//   } else if (userType == "Warden") {
//     if (!wardenEmails.contains(email)) {
//       Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//       setState(() {
//         isSigningUp = false;
//       });
//       return;
//     }
//   }

//   try {
//     User? user = await _auth.signUpWithEmailAndPassword(email, password);

//     if (user != null) {
//       // Save role in Firebase (Firestore example)
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'email': email,
//         'role': userType!.toLowerCase(),
//         if (userType == "Student") 'rollNumber': rollNumber,
//       });

//       Fluttertoast.showToast(msg: "User successfully created");

//       // Navigate after signup
//       if (userType == "Student") {
//         Routemaster.of(context).push('/student-home');
//       } else if (userType == "Warden") {
//         Routemaster.of(context).push('/warden-home');
//       }

//     } else {
//       Fluttertoast.showToast(msg: "Signup failed.");
//     }
//   Routemaster.of(context).push('/');
//   } catch (e) {
//     Fluttertoast.showToast(msg: "Error during sign up: $e");
//   } finally {
//     setState(() {
//       isSigningUp = false;
//     });
//   }
// }
// }

//   Future<void> _signUp() async {
//     if (userType == null) {
//       Fluttertoast.showToast(msg: "Please select a user type.");
//       return;
//     }

//     setState(() {
//       isSigningUp = true;
//     });

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     String rollNumber = _rollNumberController.text.trim();

//     if (userType == "Student") {
//       bool isValid = await isValidRollNumber(rollNumber);
//       if (!isValid) {
//         Fluttertoast.showToast(msg: "Invalid Roll Number.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     } else if (userType == "Warden") {
//       if (!wardenEmails.contains(email)) {
//         Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     }

//     try {
//       User? user = await _auth.signUpWithEmailAndPassword(email, password);

//       if (user != null) {
//         Fluttertoast.showToast(msg: "User successfully created");
//         if (userType == "Student") {
//           Routemaster.of(context).push('/');
//         } else if (userType == "Warden") {
//           Routemaster.of(context).push('/');
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Signup failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error during sign up: $e");
//     } finally {
//       setState(() {
//         isSigningUp = false;
//       });
//     }
//   }
// }

// import 'dart:convert';
// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:routemaster/routemaster.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuthServices _auth = FirebaseAuthServices();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();

//   bool isSigningUp = false;
//   String? userType;
//   Map<String, String> validStudents = {};
//   List<String> wardenEmails = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCsvData();
//   }

//   Future<void> _loadCsvData() async {
//     try {
//       final csvContent =
//           await rootBundle.loadString('assets/G5_Hostel_Details.csv');
//       final lines = const LineSplitter().convert(csvContent);

//       for (var line in lines.skip(1)) {
//         final columns = line.split(',');
//         if (columns.length >= 4) {
//           if (columns[11].trim().toUpperCase() == 'STUDENT') {
//             validStudents[columns[3].trim()] =
//                 columns[1].trim(); // Roll No -> Name
//           } else if (columns[11].trim().toUpperCase() == 'WARDEN') {
//             wardenEmails.add(columns[1].trim());
//           }
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error loading CSV data: $e");
//     }
//   }

//   Future<bool> isValidRollNumber(String rollNumber) async {
//     return validStudents.containsKey(rollNumber.trim());
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _rollNumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("SignUp"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: userType,
//                 hint: const Text("Select User Type"),
//                 items: const [
//                   DropdownMenuItem(value: "Student", child: Text("Student")),
//                   DropdownMenuItem(value: "Warden", child: Text("Warden")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     userType = value;
//                   });
//                 },
//               ),
//               if (userType == "Student") ...[
//                 const SizedBox(height: 10),
//                 FormContainerWidget(
//                   controller: _rollNumberController,
//                   hintText: "Roll Number",
//                   isPasswordField: false,
//                 ),
//               ],
//               const SizedBox(height: 10),
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
//                 onTap: _signUp,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: isSigningUp
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signUp() async {
//     if (userType == null) {
//       Fluttertoast.showToast(msg: "Please select a user type.");
//       return;
//     }

//     setState(() {
//       isSigningUp = true;
//     });

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     String rollNumber = _rollNumberController.text.trim();

//     if (userType == "Student") {
//       bool isValid = await isValidRollNumber(rollNumber);
//       if (!isValid) {
//         Fluttertoast.showToast(msg: "Invalid Roll Number.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     } else if (userType == "Warden") {
//       if (!wardenEmails.contains(email)) {
//         Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     }

//     try {
//       User? user = await _auth.signUpWithEmailAndPassword(email, password);

//       if (user != null) {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'email': email,
//           'role': userType!.toLowerCase(),
//           if (userType == "Student") 'rollNumber': rollNumber,
//         });

//         Fluttertoast.showToast(msg: "User successfully created");

//         if (userType == "Student") {
//           Routemaster.of(context).push('/');
//         } else if (userType == "Warden") {
//           Routemaster.of(context).push('/');
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Signup failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error during sign up: $e");
//     } finally {
//       setState(() {
//         isSigningUp = false;
//       });
//     }
//   }
// }

// // import 'dart:convert';
// import 'dart:convert';

// import 'package:campusleave/features/auth/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

// import 'package:campusleave/features/auth/user_auth/widget/form_container_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:routemaster/routemaster.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuthServices _auth = FirebaseAuthServices();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();

//   bool isSigningUp = false;
//   String? userType;
//   Map<String, String> validStudents = {};
//   List<String> wardenEmails = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCsvData();
//   }

//   Future<void> _loadCsvData() async {
//     try {
//       final csvContent =
//           await rootBundle.loadString('assets/G5_Hostel_Details.csv');
//       final lines = const LineSplitter().convert(csvContent);

//       for (var line in lines.skip(1)) {
//         final columns = line.split(',');
//         if (columns.length >= 4) {
//           if (columns[11].trim().toUpperCase() == 'STUDENT') {
//             validStudents[columns[3].trim()] =
//                 columns[1].trim(); // Roll No -> Name
//           } else if (columns[11].trim().toUpperCase() == 'WARDEN') {
//             wardenEmails.add(columns[1].trim());
//           }
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error loading CSV data: $e");
//     }
//   }

//   Future<bool> isValidRollNumber(String rollNumber) async {
//     return validStudents.containsKey(rollNumber.trim());
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _rollNumberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("SignUp"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: userType,
//                 hint: const Text("Select User Type"),
//                 items: const [
//                   DropdownMenuItem(value: "Student", child: Text("Student")),
//                   DropdownMenuItem(value: "Warden", child: Text("Warden")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     userType = value;
//                   });
//                 },
//               ),
//               if (userType == "Student") ...[
//                 const SizedBox(height: 10),
//                 FormContainerWidget(
//                   controller: _rollNumberController,
//                   hintText: "Roll Number",
//                   isPasswordField: false,
//                 ),
//               ],
//               const SizedBox(height: 10),
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
//                 onTap: _signUp,
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: isSigningUp
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signUp() async {
//     if (userType == null) {
//       Fluttertoast.showToast(msg: "Please select a user type.");
//       return;
//     }

//     setState(() {
//       isSigningUp = true;
//     });

//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     String rollNumber = _rollNumberController.text.trim();

//     if (userType == "Student") {
//       bool isValid = await isValidRollNumber(rollNumber);
//       if (!isValid) {
//         Fluttertoast.showToast(msg: "Invalid Roll Number.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     } else if (userType == "Warden") {
//       if (!wardenEmails.contains(email)) {
//         Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//         setState(() {
//           isSigningUp = false;
//         });
//         return;
//       }
//     }

//     try {
//       User? user = await _auth.signUpWithEmailAndPassword(email, password);

//       if (user != null) {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'email': email,
//           'role': userType!.toLowerCase(),
//           if (userType == "Student") 'rollNumber': rollNumber,
//         });

//         Fluttertoast.showToast(msg: "User successfully created");

//         if (userType == "Student") {
//           Routemaster.of(context).push('/');
//         } else if (userType == "Warden") {
//           Routemaster.of(context).push('/');
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Signup failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error during sign up: $e");
//     } finally {
//       setState(() {
//         isSigningUp = false;
//       });
//     }
//   }
// }

// import 'dart:convert';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController rollNumberController = TextEditingController();
//   String? userType;

//   Future<void> loadCsvData(
//       /*Map<String, Map<String, String>>*/ dynamic userDetails) async {
//     try {
//       final csvContent = await rootBundle.loadString('assets/G5_Hostel.csv');
//       final lines = const LineSplitter().convert(csvContent);

//       for (var line in lines.skip(1)) {
//         final columns = line.split(',');
//         if (columns.length >= 14) {
//           if (userType == 'Student') {
//             userDetails[columns[3].trim()] = {
//               "name": columns[1].trim(),
//               "facultyAdvisorEmail": columns[13].trim(),
//               "wardenEmail": columns[15].trim(),
//             };
//           } else if (userType == "Faculty Advisor") {
//             userDetails[columns[12].trim()] = columns[13].trim();
//           } else if (userType == 'Warden') {
//             userDetails[columns[14].trim()] = columns[15].trim();
//           }
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error occured while fetching details: $e");
//     }
//   }

//   Future<void> signUp(BuildContext context, WidgetRef ref) async {
//     if (userType == null) {
//       Fluttertoast.showToast(msg: "Please select a user type.");
//       return;
//     }

//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String rollNumber = rollNumberController.text.trim();
//     String role;

//     // final userDetails = <String, Map<String, String>>{};
//     // await loadCsvData(userDetails);
//     // print(userDetails);

//     if (userType == "Student") {
//       role = 'student';
//       final userDetails = <String, Map<String, String>>{};
//       await loadCsvData(userDetails);
//       if (!userDetails.containsKey(rollNumber)) {
//         Fluttertoast.showToast(msg: "Invalid Roll Number.");
//         return;
//       }

//       final facultyAdvisorEmail =
//           userDetails[rollNumber]?['facultyAdvisorEmail'];
//       final wardenEmail = userDetails[rollNumber]?['wardenEmail'];

//       if (facultyAdvisorEmail == null || wardenEmail == null) {
//         Fluttertoast.showToast(
//             msg: "Faculty Advisor or Warden details not found.");
//         return;
//       }

//       // Proceed with sign-up using facultyAdvisorEmail and wardenEmail
//       try {
//         ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
//               context: context,
//               email: email,
//               password: password,
//               rollNumber: rollNumber,
//               userDetails: userDetails,
//               role: role,
//             );

//         Fluttertoast.showToast(msg: "User successfully created");
//         Routemaster.of(context).push('/login');
//       } catch (e) {
//         Fluttertoast.showToast(msg: "Error during sign up: $e");
//       }
//     } else if (userType == "Warden") {
//       role = 'warden';
//       final userDetails = <String, String>{};
//       await loadCsvData(userDetails);
//       if (/*!userDetails.values.any((student) => student['wardenEmail'] == email)*/
//           !userDetails.containsValue(email)) {
//         Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//         return;
//       }

//       // Warden sign-up logic
//       try {
//         ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
//               context: context,
//               email: email,
//               password: password,
//               rollNumber: '',
//               userDetails: userDetails,
//               role: role,
//             );

//         Fluttertoast.showToast(msg: "User successfully created");
//         Routemaster.of(context).push('/login');
//       } catch (e) {
//         Fluttertoast.showToast(msg: "Error during sign up: $e");
//       }
//     } else if (userType == "Faculty Advisor") {
//       role = 'faculty';
//       final userDetails = <String, String>{};
//       await loadCsvData(userDetails);
//       late String name;
//       late String mail;
//       for (var entries in userDetails.entries) {
//         name = entries.key;
//         mail = entries.value;
//       }
//       // print("usertype fa ha!!");
//       // print(userDetails);
//       // print("key: $name");
//       // print("Value: $mail");
//       if (/*!userDetails.values.any((student) => student['wardenEmail'] == email)*/
//           !userDetails.containsValue(email)) {
//         Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
//         return;
//       }

//       // Warden sign-up logic
//       try {
//         ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
//               context: context,
//               email: email,
//               password: password,
//               rollNumber: '',
//               userDetails: userDetails,
//               role: role,
//             );

//         Fluttertoast.showToast(msg: "User successfully created");
//         Routemaster.of(context).push('/login');
//       } catch (e) {
//         Fluttertoast.showToast(msg: "Error during sign up: $e");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, _) {
//         return Scaffold(
//           appBar: AppBar(
//             // automaticallyImplyLeading: false,
//             title: const Text("SignUp"),
//           ),
//           body: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   DropdownButton<String>(
//                     value: userType,
//                     hint: const Text("Select User Type"),
//                     items: const [
//                       DropdownMenuItem(
//                           value: "Student", child: Text("Student")),
//                       DropdownMenuItem(
//                           value: "Faculty Advisor",
//                           child: Text("Faculty Advisor")),
//                       DropdownMenuItem(value: "Warden", child: Text("Warden")),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         userType = value;
//                       });
//                     },
//                   ),
//                   if (userType == "Student") ...[
//                     const SizedBox(height: 10),
//                     FormContainerWidget(
//                       controller: rollNumberController,
//                       hintText: "Roll Number",
//                       isPasswordField: false,
//                     ),
//                   ],
//                   const SizedBox(height: 10),
//                   FormContainerWidget(
//                     controller: emailController,
//                     hintText: "Email",
//                     isPasswordField: false,
//                   ),
//                   const SizedBox(height: 10),
//                   FormContainerWidget(
//                     controller: passwordController,
//                     hintText: "Password",
//                     isPasswordField: true,
//                   ),
//                   const SizedBox(height: 30),
//                   GestureDetector(
//                     onTap: () => signUp(context, ref),
//                     child: Container(
//                       width: double.infinity,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// updated

import 'dart:convert';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  String? userType;

  Future<void> loadCsvData(
      /*Map<String, Map<String, String>>*/ dynamic userDetails) async {
    try {
      final csvContent = await rootBundle.loadString('assets/G5_Hostel.csv');
      final lines = const LineSplitter().convert(csvContent);

      for (var line in lines.skip(1)) {
        final columns = line.split(',');
        if (columns.length >= 14) {
          if (userType == 'Student') {
            userDetails[columns[3].trim()] = {
              "name": columns[1].trim(),
              "facultyAdvisorEmail": columns[13].trim(),
              "wardenEmail": columns[15].trim(),
            };
          } else if (userType == "Faculty Advisor") {
            userDetails[columns[12].trim()] = columns[13].trim();
          } else if (userType == 'Warden') {
            userDetails[columns[14].trim()] = columns[15].trim();
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error occured while fetching details: $e");
    }
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    if (userType == null) {
      Fluttertoast.showToast(msg: "Please select a user type.");
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String rollNumber = rollNumberController.text.trim();
    String role;

    // final userDetails = <String, Map<String, String>>{};
    // await loadCsvData(userDetails);
    // print(userDetails);

    if (userType == "Student") {
      role = 'student';
      final userDetails = <String, Map<String, String>>{};
      await loadCsvData(userDetails);
      if (!userDetails.containsKey(rollNumber)) {
        Fluttertoast.showToast(msg: "Invalid Roll Number.");
        return;
      }

      final facultyAdvisorEmail =
          userDetails[rollNumber]?['facultyAdvisorEmail'];
      final wardenEmail = userDetails[rollNumber]?['wardenEmail'];

      if (facultyAdvisorEmail == null || wardenEmail == null) {
        Fluttertoast.showToast(
            msg: "Faculty Advisor or Warden details not found.");
        return;
      }

      // Proceed with sign-up using facultyAdvisorEmail and wardenEmail
      try {
        ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
              context: context,
              email: email,
              password: password,
              rollNumber: rollNumber,
              userDetails: userDetails,
              role: role,
            );

        Fluttertoast.showToast(msg: "User successfully created");
        Routemaster.of(context).push('/login');
      } catch (e) {
        Fluttertoast.showToast(msg: "Error during sign up: $e");
      }
    } else if (userType == "Warden") {
      role = 'warden';
      final userDetails = <String, String>{};
      await loadCsvData(userDetails);
      if (/*!userDetails.values.any((student) => student['wardenEmail'] == email)*/
          !userDetails.containsValue(email)) {
        Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
        return;
      }

      // Warden sign-up logic
      try {
        ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
              context: context,
              email: email,
              password: password,
              rollNumber: '',
              userDetails: userDetails,
              role: role,
            );

        Fluttertoast.showToast(msg: "User successfully created");
        Routemaster.of(context).push('/login');
      } catch (e) {
        Fluttertoast.showToast(msg: "Error during sign up: $e");
      }
    } else if (userType == "Faculty Advisor") {
      role = 'faculty';
      final userDetails = <String, String>{};
      await loadCsvData(userDetails);
      late String name;
      late String mail;
      for (var entries in userDetails.entries) {
        name = entries.key;
        mail = entries.value;
      }
      // print("usertype fa ha!!");
      // print(userDetails);
      // print("key: $name");
      // print("Value: $mail");
      if (/*!userDetails.values.any((student) => student['wardenEmail'] == email)*/
          !userDetails.containsValue(email)) {
        Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
        return;
      }

      // Warden sign-up logic
      try {
        ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
              context: context,
              email: email,
              password: password,
              rollNumber: '',
              userDetails: userDetails,
              role: role,
            );

        Fluttertoast.showToast(msg: "User successfully created");
        Routemaster.of(context).push('/login');
      } catch (e) {
        Fluttertoast.showToast(msg: "Error during sign up: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create an Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: userType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                    hint: const Text("Select User Type"),
                    items: const [
                      DropdownMenuItem(
                          value: "Student", child: Text("Student")),
                      DropdownMenuItem(
                          value: "Faculty Advisor",
                          child: Text("Faculty Advisor")),
                      DropdownMenuItem(value: "Warden", child: Text("Warden")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        userType = value;
                      });
                    },
                  ),
                  if (userType == "Student") ...[
                    const SizedBox(height: 10),
                    FormContainerWidget(
                      controller: rollNumberController,
                      hintText: "Roll Number",
                      isPasswordField: false,
                    ),
                  ],
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    controller: emailController,
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    controller: passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => signUp(context, ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
