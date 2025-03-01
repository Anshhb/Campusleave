// // import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:campusleave/features/warde_home/screens/warden_email_read_only_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WardenApprovedMailScreen extends ConsumerWidget {
//   const WardenApprovedMailScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Approved Mails'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('emailRequests')
//             .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
//             .where('status', isEqualTo: 'approved')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No approved requests found.'));
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

// class WardenApprovedMailScreen extends ConsumerWidget {
//   const WardenApprovedMailScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Approved Mails',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         elevation: 5,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blueAccent, Colors.lightBlue],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('emailRequests')
//               .where('advisorEmail', isEqualTo: ref.read(userProvider)?.email)
//               .where('status', isEqualTo: 'approved')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(
//                   child: Text('Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.white)));
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text('No approved requests found.',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
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
//       padding: const EdgeInsets.all(10),
//       itemBuilder: (context, index) {
//         final request = requests[index].data() as Map<String, dynamic>;
//         final emailId = request['userId'] as String? ?? '';

//         return Card(
//           elevation: 5,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//           child: ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             title: Text(
//               emailId,
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent),
//             ),
//             trailing:
//                 const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => WardenEmailReadOnlyScreen(request: request),
//                 ),
//               );
//             },
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

class WardenApprovedMailScreen extends ConsumerWidget {
  const WardenApprovedMailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approved Mails',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('emailRequests')
              .where('advisorEmail', isEqualTo: ref.read(userProvider)?.email)
              .where('status', isEqualTo: 'approved')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No approved requests found.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final request = requests[index].data() as Map<String, dynamic>;
        final emailId = request['userId'] as String? ?? '';
        final requestId = requests[index].id; // Get Firestore document ID

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Text(
              emailId,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
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
