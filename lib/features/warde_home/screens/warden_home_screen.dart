// import 'package:campusleave/features/auth/controller/auth_controller.dart';
// import 'package:campusleave/features/warde_home/drawers/warden_list_drawer.dart';
// import 'package:campusleave/features/warde_home/drawers/warden_profile_drawer.dart';
// import 'package:campusleave/features/warde_home/screens/warden_email_details_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WardenHomeScreen extends ConsumerWidget {
//   const WardenHomeScreen({super.key});
//     void logOut(WidgetRef ref) {
//     ref.read(authControllerProvider.notifier).logOut();
//   }

//   void _acceptAllRequests(BuildContext context, WidgetRef ref, List<DocumentSnapshot> requests) async {
//     bool confirm = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm'),
//         content: const Text('Are you sure you want to approve all leave requests?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );

//     if (confirm) {
//       final batch = FirebaseFirestore.instance.batch();

//       for (var request in requests) {
//         batch.update(
//           FirebaseFirestore.instance.collection('emailRequests').doc(request.id),
//           {'status': 'approved'},
//         );
//       }

//       try {
//         await batch.commit();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('All requests have been approved.')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to approve all requests: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//         return Scaffold(
//       appBar: AppBar(
//         title: const Text('Warden Home Screen'),
//         actions: [
//           Builder(
//             builder: (context) => IconButton(
//               icon: const Icon(Icons.account_circle),
//               onPressed: () => Scaffold.of(context).openEndDrawer(),
//             ),
//           ),
//         ],
//       ),
//       drawer: const WardenListDrawer(),
//       endDrawer: const WardenProfileDrawer(),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('emailRequests')
//             .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
//             .where('status', isEqualTo: 'pending')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No pending requests found.'));
//           }

//           return _buildRequestsList(context, snapshot.data!.docs);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           QuerySnapshot snapshot = await FirebaseFirestore.instance
//               .collection('emailRequests')
//               .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
//               .where('status', isEqualTo: 'pending')
//               .get();
//           _acceptAllRequests(context, ref, snapshot.docs);
//         },
//         child: const Icon(Icons.done_all),
//         tooltip: 'Accept All Requests',
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
//                     builder: (_) => WardenEmailDetailsScreen(request: request, requestId: requests[index].id),
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



import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/features/warde_home/drawers/warden_list_drawer.dart';
import 'package:campusleave/features/warde_home/drawers/warden_profile_drawer.dart';
import 'package:campusleave/features/warde_home/screens/warden_email_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WardenHomeScreen extends ConsumerWidget {
  const WardenHomeScreen({super.key});
  
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void _acceptAllRequests(BuildContext context, WidgetRef ref, List<DocumentSnapshot> requests) async {
    if (requests.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Pending Requests'),
          content: const Text('There are no pending requests to approve.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to approve all leave requests?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm) {
      final batch = FirebaseFirestore.instance.batch();

      for (var request in requests) {
        batch.update(
          FirebaseFirestore.instance.collection('emailRequests').doc(request.id),
          {'status': 'approved'},
        );
      }

      try {
        await batch.commit();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All requests have been approved.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve all requests: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warden Home Screen'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      drawer: const WardenListDrawer(),
      endDrawer: const WardenProfileDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emailRequests')
            .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending requests found.'));
          }

          return _buildRequestsList(context, snapshot.data!.docs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('emailRequests')
              .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
              .where('status', isEqualTo: 'pending')
              .get();
          _acceptAllRequests(context, ref, snapshot.docs);
        },
        child: const Icon(Icons.done_all),
        tooltip: 'Accept All Requests',
      ),
    );
  }

  Widget _buildRequestsList(BuildContext context, List<DocumentSnapshot> requests) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index].data() as Map<String, dynamic>; // Explicit cast
        final emailId = request['userId'] as String? ?? ''; // Replace with actual sender email ID field

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            child: ListTile(
              title: Text(emailId),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WardenEmailDetailsScreen(request: request, requestId: requests[index].id),
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
