// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class WardenEmailDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> request;
//   final String requestId;
//   const WardenEmailDetailsScreen({required this.request, required this.requestId, super.key});
// void _updateRequestStatus(BuildContext context, String status) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(requestId)
//           .update({'status': status});
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Request status updated to $status')),
//       );
//       Navigator.of(context).pop();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update request status: $e')),
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(request['subject'] ?? 'Leave Request'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               request['body'] ?? '',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _updateRequestStatus(context, 'approved'),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   child: const Text('Accept',style: TextStyle(color: Colors.white), ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => _updateRequestStatus(context, 'declined'),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text('Decline', style: TextStyle(color: Colors.white),),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// updated

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WardenEmailDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> request;
  final String requestId;
  const WardenEmailDetailsScreen(
      {required this.request, required this.requestId, super.key});
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
        title: const Text('Email Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request['subject'] ?? 'No Subject',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    request['body'] ?? 'No Content Available',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            _updateRequestStatus(context, 'approved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Accept',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            _updateRequestStatus(context, 'declined'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Decline',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:campusleave/models/email_request_model.dart';

// class WardenEmailDetailsScreen extends StatefulWidget {
//   final EmailRequest emailRequest;

//   const WardenEmailDetailsScreen({
//     required this.emailRequest,
//     super.key,
//   });

//   @override
//   State<WardenEmailDetailsScreen> createState() => _WardenEmailDetailsScreenState();
// }

// class _WardenEmailDetailsScreenState extends State<WardenEmailDetailsScreen> {
//   bool isDeleted = false;

//   void _removeFromRecentActivity() {
//     setState(() {
//       isDeleted = true;
//     });
//     Navigator.of(context).pop();
//   }

//   // void _updateRequestStatus(String status) async {
//   //   try {
//   //     await FirebaseFirestore.instance
//   //         .collection('emailRequests')
//   //         .doc(widget.requestId)
//   //         .update({'status': status});
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Request status updated to $status')),
//   //     );
//   //     Navigator.of(context).pop();
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to update request status: $e')),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (isDeleted) {
//       return const SizedBox();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details', style: TextStyle(fontWeight: FontWeight.bold)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Remove from Recent Activity'),
//                   content: const Text('Are you sure you want to remove this email from recent activity?'),
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
//               // const SizedBox(height: 20),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     ElevatedButton(
//               //       onPressed: () => _updateRequestStatus('approved'),
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: Colors.green,
//               //         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               //       ),
//               //       child: const Text('Accept', style: TextStyle(color: Colors.white, fontSize: 16)),
//               //     ),
//               //     ElevatedButton(
//               //       onPressed: () => _updateRequestStatus('declined'),
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: Colors.red,
//               //         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               //       ),
//               //       child: const Text('Decline', style: TextStyle(color: Colors.white, fontSize: 16)),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
