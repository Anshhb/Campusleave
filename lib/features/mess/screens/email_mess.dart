import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
class EmailToMessPage extends StatefulWidget {
  const EmailToMessPage({super.key});

  @override
  _EmailToMessPageState createState() => _EmailToMessPageState();
}

class _EmailToMessPageState extends State<EmailToMessPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendEmail(BuildContext context, WidgetRef ref, String emailBody) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mess@example.com', // Replace with the actual mess email address
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Mess Notification',
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Email to Mess'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 300, // Increase the height to give more space for writing
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 196, 195, 195)),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromARGB(255, 222, 208, 208),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _emailController,
                        maxLines: null, // Allow multiple lines
                        expands: true, // Allow the TextField to expand vertically
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Compose your email',
                        ),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
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
