// // import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/warde_home/screens/warden_email_read_only_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WardenDeclinedMailScreen extends ConsumerWidget {
//   const WardenDeclinedMailScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//  return Scaffold(
//       appBar: AppBar(
//         title: const Text('Declined Mails'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('emailRequests')
//             .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
//             .where('status', isEqualTo: 'declined')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No declined requests found.'));
//           }

//           return _buildRequestsList(context, snapshot.data!.docs);
//         },
//       ),
//     );
//   }

//   Widget _buildRequestsList(BuildContext context, List<DocumentSnapshot> requests) {
//     return ListView.builder(
//       itemCount: requests.length,
//       itemBuilder: (context, index) {
//         final request = requests[index].data() as Map<String, dynamic>; // Explicit cast
//         final emailId = request['userId'] as String? ?? ''; // Replace with actual sender email ID field

//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Card(
//             child: ListTile(
//               title: Text(emailId),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => WardenEmailReadOnlyScreen(request: request),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// updated

// // import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/warde_home/screens/warden_email_read_only_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WardenDeclinedMailScreen extends ConsumerWidget {
//   const WardenDeclinedMailScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Declined Mails'),
//         backgroundColor: Colors.redAccent,
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.redAccent, Colors.pinkAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('emailRequests')
//               .where('advisorEmail', isEqualTo: ref.read(userProvider)?.email)
//               .where('status', isEqualTo: 'declined')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No declined requests found.',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               );
//             }

//             return _buildRequestsList(context, snapshot.data!.docs);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildRequestsList(
//       BuildContext context, List<DocumentSnapshot> requests) {
//     return ListView.builder(
//       itemCount: requests.length,
//       itemBuilder: (context, index) {
//         final request = requests[index].data() as Map<String, dynamic>;
//         final emailId = request['userId'] as String? ?? '';

//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 5,
//             child: ListTile(
//               leading: const Icon(Icons.email, color: Colors.redAccent),
//               title: Text(
//                 emailId,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               trailing:
//                   const Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         WardenEmailReadOnlyScreen(request: request),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/features/warde_home/screens/warden_email_read_only_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WardenDeclinedMailScreen extends ConsumerWidget {
  const WardenDeclinedMailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Declined Mails'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('emailRequests')
              .where('advisorEmail', isEqualTo: ref.read(userProvider)?.email)
              .where('status', isEqualTo: 'declined')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No declined requests found.',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            }

            return _buildRequestsList(context, snapshot.data!.docs);
          },
        ),
      ),
    );
  }

  Widget _buildRequestsList(
      BuildContext context, List<DocumentSnapshot> requests) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index].data() as Map<String, dynamic>;
        final emailId = request['userId'] as String? ?? '';
        final requestId = requests[index].id; // Get Firestore document ID

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.redAccent),
              title: Text(
                emailId,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WardenEmailReadOnlyScreen(
                      request: {...request, 'id': requestId}, // Pass ID for deletion
                      onRemove: () {
                        _deleteEmailFromFirestore(requestId, context);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteEmailFromFirestore(String requestId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('emailRequests')
          .doc(requestId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete email: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
