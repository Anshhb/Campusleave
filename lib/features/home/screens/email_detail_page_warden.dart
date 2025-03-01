// import 'package:campusleave/models/email_request_model.dart';
// import 'package:flutter/material.dart';

// class EmailDetailPageWardenWarden extends StatelessWidget {
//   final EmailRequest emailRequest;

//   const EmailDetailPageWardenWarden({super.key, required this.emailRequest});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Detail - Warden'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Subject: ${emailRequest.subject}'),
//             SizedBox(height: 8),
//             Text('Sent to: ${emailRequest.wardenEmail}'),
//             SizedBox(height: 8),
//             Text('Body: ${emailRequest.body}'),
//             SizedBox(height: 8),
//             Text('Status: ${emailRequest.status}'),
//             SizedBox(height: 8),
//             Text('Sent on: ${emailRequest.formattedDate}'),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:campusleave/models/email_request_model.dart';

// class EmailDetailPageWarden extends StatelessWidget {
//   final EmailRequest emailRequest;

//   const EmailDetailPageWarden({super.key, required this.emailRequest});

//   Future<void> _deleteEmail(BuildContext context) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(emailRequest.id)
//           .delete();
//       Navigator.of(context).pop(); // Close detail page after deletion
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.blue),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Delete Confirmation'),
//                   content: const Text('Are you sure you want to delete this email request?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () => _deleteEmail(context),
//                       child: const Text('Delete'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'To: ${emailRequest.wardenEmail}',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 'Subject: ${emailRequest.subject}',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 'Status: ${emailRequest.status}',
//                 style: TextStyle(
//                   color: emailRequest.status == 'pending'
//                       ? Colors.yellow
//                       : emailRequest.status == 'approved'
//                           ? Colors.green
//                           : Colors.red,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.0,
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               const Text(
//                 'Body:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 emailRequest.body,
//                 style: const TextStyle(fontSize: 16.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:campusleave/models/email_request_model.dart';

class EmailDetailPageWarden extends StatefulWidget {
  final EmailRequest emailRequest;

  const EmailDetailPageWarden({super.key, required this.emailRequest});

  @override
  _EmailDetailPageWardenState createState() => _EmailDetailPageWardenState();
}

class _EmailDetailPageWardenState extends State<EmailDetailPageWarden> {
  bool _isDeleted = false;

  void _deleteEmail() {
    setState(() {
      _isDeleted = true;
    });
    Navigator.of(context).pop(); // Close detail page after marking as deleted
  }

  @override
  Widget build(BuildContext context) {
    if (_isDeleted) {
      return const Scaffold(
        body: Center(child: Text('This email request has been removed from recent activity.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.blue),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Confirmation'),
                  content: const Text('Are you sure you want to remove this email from recent activity?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _deleteEmail();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To: ${widget.emailRequest.wardenEmail}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Subject: ${widget.emailRequest.subject}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Status: ${widget.emailRequest.status}',
                style: TextStyle(
                  color: widget.emailRequest.status == 'pending'
                      ? Colors.yellow
                      : widget.emailRequest.status == 'approved'
                          ? Colors.green
                          : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Body:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.emailRequest.body,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}