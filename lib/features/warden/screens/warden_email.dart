// import 'package:campusleave/core/utils/email_utils.dart';
// import 'package:campusleave/features/auth/user_auth/user_controller/user_auth_controller.dart';
// // import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/models/email_request_model.dart';
// import 'package:campusleave/models/warden_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:url_launcher/url_launcher.dart';

// class EmailToWardenPage extends StatefulWidget {
//   final WardenModel warden;

//   const EmailToWardenPage({super.key, required this.warden});

//   @override
//   _EmailToWardenState createState() => _EmailToWardenState();
// }

// class _EmailToWardenState extends State<EmailToWardenPage> with WidgetsBindingObserver {
//   bool _emailSentConfirmation = false;
//   WidgetRef? _widgetRef; // Store WidgetRef
//   late TextEditingController _emailController; // Controller for the email body

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initializeEmailTemplate();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _emailController.dispose(); // Dispose of the controller
//     super.dispose();
//   }

//   void _initializeEmailTemplate() {
//     final user = _widgetRef?.read(userProvider);
//     if (user != null) {
//       final emailTemplate = generateEmailTemplateWarden(user.name, user.email, widget.warden);
//       _emailController = TextEditingController(text: emailTemplate);
//     } else {
//       _emailController = TextEditingController();
//     }
//   }

//   Future<void> _sendEmail(BuildContext context, WidgetRef ref, String emailBody) async {
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: widget.warden.email,
//       query: _encodeQueryParameters(<String, String>{
//         'subject': 'Leave Request',
//         'body': emailBody,
//       }),
//     );

//     try {
//       await launchUrl(emailLaunchUri);
//     } catch (e) {
//       // Handle error launching email client
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Could not launch email client: $e')),
//       );
//     }
//   }

//   String _encodeQueryParameters(Map<String, String> params) {
//     return params.entries
//         .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//   }

//   Future<void> _showEmailSentConfirmationDialog(WidgetRef ref) async {
//     if (!_emailSentConfirmation) {
//       bool? result = await showDialog<bool>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Email Sent Confirmation'),
//           content: Text('Did you send the email to ${widget.warden.email}?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: const Text('No'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text('Yes'),
//             ),
//           ],
//         ),
//       );

//       if (result == true) {
//         // Mark email as sent and save to Firestore
//         setState(() {
//           _emailSentConfirmation = true;
//         });

//         final user = ref.watch(userProvider)!;
//         final emailTemplate = _emailController.text;

//         final emailRequest = EmailRequest(
//           id: '',
//           userId: user.email,
//           wardenId: widget.warden.id,
//           EmailToWardenPage: widget.warden.email,
//           subject: 'Leave Request',
//           body: emailTemplate,
//           status: 'pending',
//           timestamp: Timestamp.now(),
//         );

//         try {
//           await FirebaseFirestore.instance.collection('emailRequests').add(emailRequest.toMap());
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Email request saved successfully.')),
//           );
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to save email request: $e')),
//           );
//         }
//       }
//     }
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);

//     if (state == AppLifecycleState.resumed && _widgetRef != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _showEmailSentConfirmationDialog(_widgetRef!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, _) {
//         _widgetRef = ref; // Store ref for later use

//         final user = ref.watch(userProvider);
//         if (user != null && _emailController.text.isEmpty) {
//           final emailTemplate = generateEmailTemplateWarden(user.name, user.email, widget.warden);
//           _emailController.text = emailTemplate;
//         }

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Email to Warden'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _emailController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       filled: true,
//                       fillColor: Color.fromARGB(255, 222, 208, 208),
//                       hintText: 'Compose your email',
//                     ),
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () => _sendEmail(context, ref, _emailController.text),
//                     icon: const Icon(Icons.send),
//                     label: const Text('Send Email'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
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

// import 'dart:convert';
// import 'package:campusleave/core/utils/email_utils.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/models/email_request_model.dart';
// // import 'package:campusleave/models/faculty_advisor_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:routemaster/routemaster.dart';

// class EmailToWardenPage extends ConsumerStatefulWidget {
//   // final String wardenEmail;
//   const EmailToWardenPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _EmailToWardenPageState createState() => _EmailToWardenPageState();
// }

// class _EmailToWardenPageState extends ConsumerState<EmailToWardenPage> {
//   final _toController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _subjectController = TextEditingController();
//   late TextEditingController _bodyController;

//   @override
//   void initState() {
//     super.initState();
//     // _toController.text = widget.advisor.email;
//     _toController.text = ref.read(userProvider)!.wardenEmail;
//     _subjectController.text = 'Leave Request';
//     _nameController.text = ref.read(userProvider)!.name;
//     _initializeEmailTemplate();
//   }

//   void _initializeEmailTemplate() {
//     final user = ref.read(userProvider);
//     if (user != null) {
//       final emailTemplate = generateEmailTemplate(user.name);
//       _bodyController = TextEditingController(text: emailTemplate);
//     } else {
//       _bodyController = TextEditingController();
//     }
//   }

//   Future sendEmail() async {
//     const serviceId = 'service_zxdv7ta';
//     const templateId = 'template_bv39p0e';
//     const userId = 'KRQ6aVsqd2DvyGHMX';
//     final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//     final response = await http.post(
//       url,
//       headers: {
//         'origin': 'http://localhost',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'service_id': serviceId,
//         'template_id': templateId,
//         'user_id': userId,
//         'template_params': {
//           'user_name': _nameController.text,
//           'receiver_email': _toController.text,
//           'user_subject': _subjectController.text,
//           'user_body': _bodyController.text,
//         }
//       }),
//     );
//     // print(response.body);

//     final user = ref.watch(userProvider)!;
//     final emailTemplate = _bodyController.text;

//     final emailRequest = EmailRequest(
//       id: '',
//       userId: user.email,
//       advisorEmail: user.wardenEmail,
//       subject: 'Leave Request',
//       body: emailTemplate,
//       status: 'pending',
//       timestamp: Timestamp.now(),
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .add(emailRequest.toMap());
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email sent successfully.')),
//       );
//       Routemaster.of(context).pop();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to sent email')),
//       );
//     }
//     return response.statusCode;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _toController.dispose();
//     _subjectController.dispose();
//     _bodyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider);
//     if (user != null && _bodyController.text.isEmpty) {
//       final emailTemplate = generateEmailTemplate(user.name);
//       _bodyController.text = emailTemplate;
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Compose Email'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               readOnly: true,
//               controller: _toController,
//               decoration: const InputDecoration(
//                 labelText: 'To',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               readOnly: true,
//               controller: _subjectController,
//               decoration: const InputDecoration(
//                 labelText: 'Subject',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.subject),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: TextField(
//                 controller: _bodyController,
//                 maxLines: null,
//                 expands: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Compose your email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () {
//                 sendEmail();
//               },
//               icon: const Icon(Icons.send),
//               label: const Text('Send Email'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// updated

import 'dart:convert';
import 'package:campusleave/core/utils/email_utils.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/models/email_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:routemaster/routemaster.dart';

class EmailToWardenPage extends ConsumerStatefulWidget {
  const EmailToWardenPage({super.key});

  @override
  _EmailToWardenPageState createState() => _EmailToWardenPageState();
}

class _EmailToWardenPageState extends ConsumerState<EmailToWardenPage> {
  // final _toController = TextEditingController();
  // final _nameController = TextEditingController();
  // final _subjectController = TextEditingController();
  // late TextEditingController _bodyController;

  final TextEditingController _toController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    // _toController.text = ref.read(userProvider)!.wardenEmail;
    // _subjectController.text = 'Leave Request';
    // _nameController.text = ref.read(userProvider)!.name;
    // _initializeEmailTemplate();
    final user = ref.read(userProvider);
      if (user != null) {
      _toController.text = user.wardenEmail;
      _subjectController.text = 'Leave Request';
      _nameController.text = user.name;
      _initializeEmailTemplate(user.name);
  }
}
  // void _initializeEmailTemplate() {
  //   final user = ref.read(userProvider);
  //   if (user != null) {
  //     final emailTemplate = generateEmailTemplate(user.name);
  //     _bodyController = TextEditingController(text: emailTemplate);
  //   } else {
  //     _bodyController = TextEditingController();
  //   }
  // }
  void _initializeEmailTemplate(String name) {
    _bodyController = TextEditingController(text: generateEmailTemplate(name));
  }

  Future sendEmail() async {
    const serviceId = 'service_zxdv7ta';
    const templateId = 'template_bv39p0e';
    const userId = 'KRQ6aVsqd2DvyGHMX';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': _nameController.text,
          'receiver_email': _toController.text,
          'user_subject': _subjectController.text,
          'user_body': _bodyController.text,
        }
      }),
    );

    final user = ref.watch(userProvider)!;

    final emailRequest = EmailRequest(
      id: '', 
      userId: user.email,
      advisorEmail: user.wardenEmail,
      subject: 'Leave Request',
      body: _bodyController.text,
      status: 'pending',
      timestamp: Timestamp.now(),
      wardenEmail: user.wardenEmail,
    );

    try {
      await FirebaseFirestore.instance
          .collection('emailRequests')
          .add(emailRequest.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sent successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      Routemaster.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send email'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return response.statusCode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _toController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    // if (user != null && _bodyController.text.isEmpty) {
    //   final emailTemplate = generateEmailTemplate(user.name);
    //   _bodyController.text = emailTemplate;
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Email',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              readOnly: true,
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.subject, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Compose your email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: sendEmail,
              icon: const Icon(Icons.send),
              label: const Text('Send Email', style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
