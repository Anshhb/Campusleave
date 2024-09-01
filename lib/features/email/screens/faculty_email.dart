
import 'package:campusleave/core/utils/email_utils.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/models/faculty_advisor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campusleave/models/email_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailToFacultyPage extends StatefulWidget {
  final FacultyAdvisor advisor;

  const EmailToFacultyPage({super.key, required this.advisor});

  @override
  _EmailToFacultyPageState createState() => _EmailToFacultyPageState();
}

class _EmailToFacultyPageState extends State<EmailToFacultyPage> with WidgetsBindingObserver {
  bool _emailSentConfirmation = false;
  WidgetRef? _widgetRef; // Store WidgetRef
  late TextEditingController _emailController; // Controller for the email body

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeEmailTemplate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _initializeEmailTemplate() {
    final user = _widgetRef?.read(userProvider);
    if (user != null) {
      final emailTemplate = generateEmailTemplate(user.name);
      _emailController = TextEditingController(text: emailTemplate);
    } else {
      _emailController = TextEditingController();
    }
  }

  Future<void> _sendEmail(BuildContext context, WidgetRef ref, String emailBody) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.advisor.email,
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Leave Request',
        'body': emailBody,
      }),
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      // Handle error launching email client
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch email client: $e')),
      );
    }
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _showEmailSentConfirmationDialog(WidgetRef ref) async {
    if (!_emailSentConfirmation) {
      bool? result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Email Sent Confirmation'),
          content: Text('Did you send the email to ${widget.advisor.email}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );

      if (result == true) {
        // Mark email as sent and save to Firestore
        setState(() {
          _emailSentConfirmation = true;
        });

        final user = ref.watch(userProvider)!;
        final emailTemplate = _emailController.text;

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
          await FirebaseFirestore.instance.collection('emailRequests').add(emailRequest.toMap());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email request saved successfully.')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save email request: $e')),
          );
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed && _widgetRef != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEmailSentConfirmationDialog(_widgetRef!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        _widgetRef = ref; // Store ref for later use

        final user = ref.watch(userProvider);
        if (user != null && _emailController.text.isEmpty) {
          final emailTemplate = generateEmailTemplate(user.name);
          _emailController.text = emailTemplate;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Email to Faculty Advisor'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 222, 208, 208),
                      hintText: 'Compose your email',
                    ),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _sendEmail(context, ref, _emailController.text),
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
          ),
        );
      },
    );
  }
}
