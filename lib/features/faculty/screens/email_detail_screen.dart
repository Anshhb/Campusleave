// import 'package:flutter/material.dart';

// class EmailDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> request;

//   const EmailDetailsScreen({super.key, required this.request});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(request['subject'] as String? ?? ''),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'From: ${request['userId'] as String? ?? ''}', // Replace with actual sender email ID field
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Subject: ${request['subject'] as String? ?? ''}'),
//             const SizedBox(height: 10),
//             Text(request['body'] as String? ?? ''), // Replace with actual email body field
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmailDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> request;
  final String requestId;

  const EmailDetailsScreen({required this.request, required this.requestId, super.key});

  void _updateRequestStatus(BuildContext context, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('emailRequests')
          .doc(requestId)
          .update({'status': status});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request status updated to $status')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update request status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(request['subject'] ?? 'Leave Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request['body'] ?? '',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _updateRequestStatus(context, 'approved'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Accept',style: TextStyle(color: Colors.white), ),
                ),
                ElevatedButton(
                  onPressed: () => _updateRequestStatus(context, 'declined'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Decline', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
