
import 'dart:convert';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/features/user_auth/widget/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      // } catch (e) {
      //   Fluttertoast.showToast(msg: "Error occured while fetching details: $e");
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred while fetching details: $e")),
      );
    }
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    // if (userType == null) {
    //   Fluttertoast.showToast(msg: "Please select a user type.");
    //   return;
    // }
    if (userType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a user type.")),
      );
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
      // if (!userDetails.containsKey(rollNumber)) {
      //   Fluttertoast.showToast(msg: "Invalid Roll Number.");
      //   return;
      // }
      if (!userDetails.containsKey(rollNumber)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Roll Number.")),
        );
        return;
      }

      final facultyAdvisorEmail =
          userDetails[rollNumber]?['facultyAdvisorEmail'];
      final wardenEmail = userDetails[rollNumber]?['wardenEmail'];

      // if (facultyAdvisorEmail == null || wardenEmail == null) {
      //   Fluttertoast.showToast(
      //       msg: "Faculty Advisor or Warden details not found.");
      //   return;
      // }
      if (facultyAdvisorEmail == null || wardenEmail == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Faculty Advisor or Warden details not found.")),
        );
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

        // Fluttertoast.showToast(msg: "User successfully created");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User successfully created")),
        );
        Routemaster.of(context).push('/login');
      } catch (e) {
        // Fluttertoast.showToast(msg: "Error during sign up: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during sign up: $e")),
        );
      }
    } else if (userType == "Warden") {
      role = 'warden';
      final userDetails = <String, String>{};
      await loadCsvData(userDetails);
      if (/*!userDetails.values.any((student) => student['wardenEmail'] == email)*/
          !userDetails.containsValue(email)) {
        // Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unauthorized Warden Email.")),
        );
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

        // Fluttertoast.showToast(msg: "User successfully created");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User successfully created")),
        );
        Routemaster.of(context).push('/login');
      } catch (e) {
        // Fluttertoast.showToast(msg: "Error during sign up: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during sign up: $e")),
        );
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
        // Fluttertoast.showToast(msg: "Unauthorized Warden Email.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unauthorized Warden Email.")),
        );
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

        // Fluttertoast.showToast(msg: "User successfully created");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User successfully created")),
        );
        Routemaster.of(context).push('/login');
      } catch (e) {
        // Fluttertoast.showToast(msg: "Error during sign up: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during sign up: $e")),
        );
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
