// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:campusleave/models/email_request_model.dart';

// class EmailDetailPage extends StatelessWidget {
//   final EmailRequest emailRequest;

//   const EmailDetailPage({super.key, required this.emailRequest});

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
//             icon: const Icon(Icons.delete, color: Colors.red),
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
//                 'To: ${emailRequest.advisorEmail}',
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



// import 'package:flutter/material.dart';
// import 'package:campusleave/models/email_request_model.dart';

// class EmailDetailPage extends StatefulWidget {
//   final EmailRequest emailRequest;

//   const EmailDetailPage({super.key, required this.emailRequest});

//   @override
//   State<EmailDetailPage> createState() => _EmailDetailPageState();
// }

// class _EmailDetailPageState extends State<EmailDetailPage> {
//   bool isDeleted = false;

//   void _removeFromRecentActivity() {
//     setState(() {
//       isDeleted = true;
//     });
//     Navigator.of(context).pop(); // Close the detail page after removal
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isDeleted) {
//       return const SizedBox(); // Return an empty widget if deleted
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Remove from Recent Activity'),
//                   content: const Text(
//                       'Are you sure you want to remove this email from the recent activity?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         _removeFromRecentActivity();
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text('Remove', style: TextStyle(color: Colors.red)),
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
//                 'To: ${widget.emailRequest.advisorEmail}',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 'Subject: ${widget.emailRequest.subject}',
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 'Status: ${widget.emailRequest.status}',
//                 style: TextStyle(
//                   color: widget.emailRequest.status == 'pending'
//                       ? Colors.yellow
//                       : widget.emailRequest.status == 'approved'
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
//                 widget.emailRequest.body,
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

class EmailDetailPage extends StatefulWidget {
  final EmailRequest emailRequest;
  final Function(String requestId) onRemove; // Callback function

  const EmailDetailPage({
    super.key,
    required this.emailRequest,
    required this.onRemove, // Require this from the parent
  });

  @override
  State<EmailDetailPage> createState() => _EmailDetailPageState();
}

class _EmailDetailPageState extends State<EmailDetailPage> {
  void _removeFromRecentActivity() {
    widget.onRemove(widget.emailRequest.id); // Notify parent
    Navigator.of(context).pop(); // Close the detail page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Remove from Recent Activity'),
                  content: const Text(
                      'Are you sure you want to remove this email from the recent activity?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _removeFromRecentActivity();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Remove',
                          style: TextStyle(color: Colors.red)),
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
                'To: ${widget.emailRequest.advisorEmail}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Subject: ${widget.emailRequest.subject}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
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
