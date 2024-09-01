import 'dart:convert';
import 'package:campusleave/core/utils/email_utils.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/models/email_request_model.dart';
import 'package:campusleave/models/faculty_advisor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SendEmailScreen extends ConsumerStatefulWidget {
  final FacultyAdvisor advisor;
  const SendEmailScreen({super.key, required this.advisor});

  @override
  // ignore: library_private_types_in_public_api
  _SendEmailScreenState createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends ConsumerState<SendEmailScreen> {
  final _toController = TextEditingController();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _toController.text = widget.advisor.email;
    _subjectController.text = 'Leave Request';
    _nameController.text = ref.read(userProvider)!.name;
    _initializeEmailTemplate();
  }

  void _initializeEmailTemplate() {
    final user = ref.read(userProvider);
    if (user != null) {
      final emailTemplate = generateEmailTemplate(user.name);
      _bodyController = TextEditingController(text: emailTemplate);
    } else {
      _bodyController = TextEditingController();
    }
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
    print(response.body);

    final user = ref.watch(userProvider)!;
    final emailTemplate = _bodyController.text;

    final emailRequest = EmailRequest(
      id: '',
      userId: user.email,
      advisorId: widget.advisor.id,
      advisorEmail: widget.advisor.email,
      subject: 'Leave Request',
      body: emailTemplate,
      status: 'pending',
      timestamp: Timestamp.now(),
    );

    try {
      await FirebaseFirestore.instance
          .collection('emailRequests')
          .add(emailRequest.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email request saved successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save email request: $e')),
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
    final user = ref.watch(userProvider);
    if (user != null && _bodyController.text.isEmpty) {
      final emailTemplate = generateEmailTemplate(user.name);
      _bodyController.text = emailTemplate;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.subject),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Compose your email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                sendEmail();
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Email'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
