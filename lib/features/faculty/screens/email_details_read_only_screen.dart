import 'package:flutter/material.dart';

class EmailDetailsReadOnlyScreen extends StatelessWidget {
  final Map<String, dynamic> request;

  const EmailDetailsReadOnlyScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${request['subject']}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('${request['body']}'),
          ],
        ),
      ),
    );
  }
}
