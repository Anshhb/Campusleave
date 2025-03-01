// import 'package:flutter/material.dart';

// class WardenEmailReadOnlyScreen extends StatelessWidget {
//   final Map<String, dynamic> request;
//   const WardenEmailReadOnlyScreen({super.key, required this.request});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Subject: ${request['subject']}', style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8.0),
//             Text('Body: ${request['body']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class WardenEmailReadOnlyScreen extends StatelessWidget {
//   final Map<String, dynamic> request;
//   const WardenEmailReadOnlyScreen({super.key, required this.request});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details'),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Subject:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   request['subject'] ?? 'No Subject',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text(
//                   'Message:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   request['body'] ?? 'No Content',
//                   style: const TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class WardenEmailReadOnlyScreen extends StatefulWidget {
//   final Map<String, dynamic> request;
//   final VoidCallback onRemove;

//   const WardenEmailReadOnlyScreen({
//     super.key,
//     required this.request,
//     required this.onRemove,
//   });

//   @override
//   _WardenEmailReadOnlyScreenState createState() => _WardenEmailReadOnlyScreenState();
// }

// class _WardenEmailReadOnlyScreenState extends State<WardenEmailReadOnlyScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Details'),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Remove Confirmation'),
//                   content: const Text(
//                       'Are you sure you want to remove this email from the list?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         widget.onRemove();
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pop(); // Close detail page after removal
//                       },
//                       child: const Text('Remove',
//                           style: TextStyle(color: Colors.red)),
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
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Subject:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   widget.request['subject'] ?? 'No Subject',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text(
//                   'Message:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   widget.request['body'] ?? 'No Content',
//                   style: const TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WardenEmailReadOnlyScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  final VoidCallback onRemove;

  const WardenEmailReadOnlyScreen({
    super.key,
    required this.request,
    required this.onRemove,
  });

  @override
  _WardenEmailReadOnlyScreenState createState() =>
      _WardenEmailReadOnlyScreenState();
}

class _WardenEmailReadOnlyScreenState extends State<WardenEmailReadOnlyScreen> {
  Future<void> _deleteEmailFromFirestore() async {
    try {
      final requestId = widget.request['id']; // Retrieve document ID
      if (requestId != null) {
        await FirebaseFirestore.instance
            .collection('emailRequests')
            .doc(requestId)
            .delete();
        widget.onRemove(); // Remove from UI
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pop(); // Close detail screen
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete email: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Confirmation'),
                  content: const Text(
                      'Are you sure you want to permanently delete this email?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: _deleteEmailFromFirestore,
                      child: const Text('Delete',
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
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Subject:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.request['subject'] ?? 'No Subject',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Message:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.request['body'] ?? 'No Content',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
