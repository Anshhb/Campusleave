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

// class SendEmailScreen extends ConsumerStatefulWidget {
//   // final String faEmail;
//   const SendEmailScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SendEmailScreenState createState() => _SendEmailScreenState();
// }

// class _SendEmailScreenState extends ConsumerState<SendEmailScreen> {
//   final _toController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _subjectController = TextEditingController();
//   late TextEditingController _bodyController;

//   @override
//   void initState() {
//     super.initState();
//     // _toController.text = widget.advisor.email;
//     _toController.text = ref.read(userProvider)!.faEmail;
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
//       advisorEmail: user.faEmail,
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

class SendEmailScreen extends ConsumerStatefulWidget {
  const SendEmailScreen({super.key});

  @override
  _SendEmailScreenState createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends ConsumerState<SendEmailScreen> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    if (user != null) {
      _toController.text = user.faEmail;
      _subjectController.text = 'Leave Request';
      _nameController.text = user.name;
      _initializeEmailTemplate(user.name);
    }
  }

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
      advisorEmail: user.faEmail,
      subject: 'Leave Request',
      body: _bodyController.text,
      status: 'pending',
      timestamp: Timestamp.now(),
        
    );

    try {
      await FirebaseFirestore.instance
          .collection('emailRequests')
          .add(emailRequest.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sent successfully.'),
        backgroundColor: Colors.green,
      ));
      Routemaster.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send email'),
        backgroundColor: Colors.red),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Email',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: sendEmail,
              icon: const Icon(Icons.send),
              label: const Text('Send Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
