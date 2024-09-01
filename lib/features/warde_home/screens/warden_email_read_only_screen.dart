import 'package:flutter/material.dart';

class WardenEmailReadOnlyScreen extends StatelessWidget {
  final Map<String, dynamic> request;
  const WardenEmailReadOnlyScreen({super.key, required this.request});

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
            Text('Subject: ${request['subject']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Body: ${request['body']}'),
          ],
        ),
      ),
    );
  }
}