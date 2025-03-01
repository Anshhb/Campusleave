// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'email_details_read_only_screen.dart'; // Import the read-only screen
// // import 'package:campusleave/features/auth/controller/auth_controller.dart';

// class DeclinedMailsScreen extends ConsumerWidget {
//   const DeclinedMailsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Declined Mails'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('emailRequests')
//             .where('advisorEmail', isEqualTo: ref.read(userProvider)?.email)
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
//                     builder: (_) => EmailDetailsReadOnlyScreen(request: request),
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

// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'email_details_read_only_screen.dart';

// class DeclinedMailsScreen extends ConsumerWidget {
//   const DeclinedMailsScreen({super.key});

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
//                         EmailDetailsReadOnlyScreen(request: request),
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'email_details_read_only_screen.dart';

class DeclinedMailsScreen extends ConsumerStatefulWidget {
  const DeclinedMailsScreen({super.key});

  @override
  ConsumerState<DeclinedMailsScreen> createState() =>
      _DeclinedMailsScreenState();
}

class _DeclinedMailsScreenState extends ConsumerState<DeclinedMailsScreen> {
  List<DocumentSnapshot> declinedRequests = [];

  void _removeRequest(String requestId) {
    setState(() {
      declinedRequests.removeWhere((doc) => doc.id == requestId);
    });
  }

  @override
  Widget build(BuildContext context) {
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

            declinedRequests = snapshot.data!.docs;
            return _buildRequestsList(context);
          },
        ),
      ),
    );
  }

  Widget _buildRequestsList(BuildContext context) {
    return ListView.builder(
      itemCount: declinedRequests.length,
      itemBuilder: (context, index) {
        final doc = declinedRequests[index];
        final request = doc.data() as Map<String, dynamic>;
        final emailId = request['userId'] as String? ?? '';

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
                    builder: (_) => EmailDetailsReadOnlyScreen(
                      request: {...request, 'id': doc.id}, // Pass request ID
                      onRemove: () => _removeRequest(doc.id),
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
}
