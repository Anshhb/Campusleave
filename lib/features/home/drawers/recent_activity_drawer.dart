// import 'package:campusleave/features/home/screens/email_detail_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:campusleave/models/email_request_model.dart';

// final emailRequestProvider = StreamProvider<List<EmailRequest>>((ref) {
//   return FirebaseFirestore.instance
//       .collection('emailRequests')
//       .orderBy('timestamp', descending: true) // Sort by timestamp in descending order
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => EmailRequest.fromMap(doc.data(), doc.id))
//           .toList());
// });

// class RecentActivityDrawer extends ConsumerWidget {
//   const RecentActivityDrawer({super.key});

//   Future<void> _deleteEmail(BuildContext context, String emailRequestId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(emailRequestId)
//           .delete();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailRequestsAsyncValue = ref.watch(emailRequestProvider);

//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             const ListTile(
//               title: Text('Recent'),
//               leading: Icon(Icons.mark_email_read_outlined),
//             ),
//             Expanded(
//               child: emailRequestsAsyncValue.when(
//                 data: (emailRequests) {
//                   if (emailRequests.isEmpty) {
//                     return const Center(child: Text('No recent activities.'));
//                   }
//                   return ListView.builder(
//                     itemCount: emailRequests.length,
//                     itemBuilder: (context, index) {
//                       final emailRequest = emailRequests[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8.0, vertical: 4.0),
//                         child: Card(
//                           elevation: 2.0,
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 8.0),
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text('Faculty Advisor'),
//                                 Text(emailRequest.formattedDate),
//                               ],
//                             ),
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(emailRequest.status),
//                                 const SizedBox(width: 5),
//                                 CircleAvatar(
//                                   radius: 5.0,
//                                   backgroundColor:
//                                       emailRequest.status == 'pending'
//                                           ? Colors.yellow
//                                           : emailRequest.status == 'approved'
//                                               ? Colors.green
//                                               : Colors.red,
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       EmailDetailPage(emailRequest: emailRequest),
//                                 ),
//                               );
//                             },
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Delete Confirmation'),
//                                     content:
//                                         const Text('Are you sure you want to delete this email request?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.of(context).pop(),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _deleteEmail(context, emailRequest.id);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Delete'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 loading: () =>
//                     const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) =>
//                     Center(child: Text('Error: $error')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:campusleave/features/home/screens/email_detail_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:campusleave/models/email_request_model.dart';

// final emailRequestProvider = StreamProvider<List<EmailRequest>>((ref) {
//   return FirebaseFirestore.instance
//       .collection('emailRequests')
//       .orderBy('timestamp', descending: true) // Sort by timestamp in descending order
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => EmailRequest.fromMap(doc.data(), doc.id))
//           .toList());
// });

// class RecentActivityDrawer extends ConsumerWidget {
//   const RecentActivityDrawer({super.key});

//   Future<void> _deleteEmail(BuildContext context, String emailRequestId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(emailRequestId)
//           .delete();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailRequestsAsyncValue = ref.watch(emailRequestProvider);

//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             const ListTile(
//               title: Text('Recent'),
//               leading: Icon(Icons.mark_email_read_outlined),
//             ),
//             Expanded(
//               child: emailRequestsAsyncValue.when(
//                 data: (emailRequests) {
//                   if (emailRequests.isEmpty) {
//                     return const Center(child: Text('No recent activities.'));
//                   }
//                   return ListView.builder(
//                     itemCount: emailRequests.length,
//                     itemBuilder: (context, index) {
//                       final emailRequest = emailRequests[index];
//                       final recipientType = emailRequest.wardenEmail.isNotEmpty
//                           ? 'Warden'
//                           : 'Faculty Advisor';
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8.0, vertical: 4.0),
//                         child: Card(
//                           elevation: 2.0,
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 8.0),
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(recipientType),
//                                 Text(emailRequest.formattedDate),
//                               ],
//                             ),
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(emailRequest.status),
//                                 const SizedBox(width: 5),
//                                 CircleAvatar(
//                                   radius: 5.0,
//                                   backgroundColor:
//                                       emailRequest.status == 'pending'
//                                           ? Colors.yellow
//                                           : emailRequest.status == 'approved'
//                                               ? Colors.green
//                                               : Colors.red,
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       EmailDetailPage(emailRequest: emailRequest),
//                                 ),
//                               );
//                             },
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Delete Confirmation'),
//                                     content:
//                                         const Text('Are you sure you want to delete this email request?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.of(context).pop(),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _deleteEmail(context, emailRequest.id);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Delete'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 loading: () =>
//                     const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) =>
//                     Center(child: Text('Error: $error')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:campusleave/features/home/screens/email_detail_page.dart';
// import 'package:campusleave/features/home/screens/email_detail_page_warden.dart'; // Import the warden detail page
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:campusleave/models/email_request_model.dart';

// final emailRequestProvider = StreamProvider<List<EmailRequest>>((ref) {
//   return FirebaseFirestore.instance
//       .collection('emailRequests')
//       .orderBy('timestamp', descending: true) // Sort by timestamp in descending order
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => EmailRequest.fromMap(doc.data(), doc.id))
//           .toList());
// });

// class RecentActivityDrawer extends ConsumerWidget {
//   const RecentActivityDrawer({super.key});

//   Future<void> _deleteEmail(BuildContext context, String emailRequestId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(emailRequestId)
//           .delete();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailRequestsAsyncValue = ref.watch(emailRequestProvider);

//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             const ListTile(
//               title: Text('Recent'),
//               leading: Icon(Icons.mark_email_read_outlined),
//             ),
//             Expanded(
//               child: emailRequestsAsyncValue.when(
//                 data: (emailRequests) {
//                   if (emailRequests.isEmpty) {
//                     return const Center(child: Text('No recent activities.'));
//                   }
//                   return ListView.builder(
//                     itemCount: emailRequests.length,
//                     itemBuilder: (context, index) {
//                       final emailRequest = emailRequests[index];
//                       final recipientType = emailRequest.wardenEmail.isNotEmpty
//                           ? 'Warden'
//                           : 'Faculty Advisor';
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8.0, vertical: 4.0),
//                         child: Card(
//                           elevation: 2.0,
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 8.0),
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(recipientType),
//                                 Text(emailRequest.formattedDate),
//                               ],
//                             ),
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(emailRequest.status),
//                                 const SizedBox(width: 5),
//                                 CircleAvatar(
//                                   radius: 5.0,
//                                   backgroundColor:
//                                       emailRequest.status == 'pending'
//                                           ? Colors.yellow
//                                           : emailRequest.status == 'approved'
//                                               ? Colors.green
//                                               : Colors.red,
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               // Check if the email was sent to the warden and navigate accordingly
//                               if (emailRequest.wardenEmail.isNotEmpty) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EmailDetailPageWarden(
//                                         emailRequest: emailRequest),
//                                   ),
//                                 );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EmailDetailPage(
//                                         emailRequest: emailRequest),
//                                   ),
//                                 );
//                               }
//                             },
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Delete Confirmation'),
//                                     content:
//                                         const Text('Are you sure you want to delete this email request?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.of(context).pop(),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _deleteEmail(context, emailRequest.id);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Delete'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 loading: () =>
//                     const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) =>
//                     Center(child: Text('Error: $error')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// updated

// import 'package:campusleave/features/home/screens/email_detail_page.dart';
// import 'package:campusleave/features/home/screens/email_detail_page_warden.dart';
// import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:campusleave/models/email_request_model.dart';

// final emailRequestProvider = StreamProvider<List<EmailRequest>>((ref) {
//   return FirebaseFirestore.instance
//       .collection('emailRequests')
//       .orderBy('timestamp', descending: true)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => EmailRequest.fromMap(doc.data(), doc.id))
//           .toList());
// });

// class RecentActivityDrawer extends ConsumerWidget {
//   const RecentActivityDrawer({super.key});

//   Future<void> _deleteEmail(BuildContext context, String emailRequestId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('emailRequests')
//           .doc(emailRequestId)
//           .delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email request deleted successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete email: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailRequestsAsyncValue = ref.watch(emailRequestProvider);
//     final user = ref.watch(userProvider)!;

//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//               child: const Text(
//                 'Recent Activity',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Expanded(
//               child: emailRequestsAsyncValue.when(
//                 data: (emailRequests) {
//                   if (emailRequests.isEmpty) {
//                     return const Center(
//                         child: Text('No recent activities.',
//                             style: TextStyle(fontSize: 16)));
//                   }
//                   return ListView.builder(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     itemCount: emailRequests.length,
//                     itemBuilder: (context, index) {
//                       final emailRequest = emailRequests[index];
//                       final recipientType =
//                           (emailRequest.advisorEmail == user.wardenEmail)
//                               ? 'Warden'
//                               : 'Faculty Advisor';
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         child: Card(
//                           elevation: 4.0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 10),
//                             title: Text(
//                               recipientType,
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.w600),
//                             ),
//                             subtitle: Row(
//                               children: [
//                                 Text(
//                                   emailRequest.status,
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(width: 6),
//                                 CircleAvatar(
//                                   radius: 6.0,
//                                   backgroundColor:
//                                       emailRequest.status == 'pending'
//                                           ? Colors.orange
//                                           : emailRequest.status == 'approved'
//                                               ? Colors.green
//                                               : Colors.red,
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   emailRequest.formattedDate,
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               if (emailRequest.wardenEmail.isNotEmpty) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EmailDetailPageWarden(
//                                         emailRequest: emailRequest),
//                                   ),
//                                 );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EmailDetailPage(
//                                         emailRequest: emailRequest),
//                                   ),
//                                 );
//                               }
//                             },
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Delete Confirmation'),
//                                     content: const Text(
//                                         'Are you sure you want to delete this email request?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.of(context).pop(),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _deleteEmail(
//                                               context, emailRequest.id);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Delete',
//                                             style:
//                                                 TextStyle(color: Colors.red)),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stack) => Center(child: Text('Error: $error')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:campusleave/features/home/screens/email_detail_page.dart';
import 'package:campusleave/features/home/screens/email_detail_page_warden.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campusleave/models/email_request_model.dart';

final emailRequestProvider = StreamProvider<List<EmailRequest>>((ref) {
  return FirebaseFirestore.instance
      .collection('emailRequests')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EmailRequest.fromMap(doc.data(), doc.id))
          .toList());
});

class RecentActivityDrawer extends ConsumerStatefulWidget {
  const RecentActivityDrawer({super.key});

  @override
  ConsumerState<RecentActivityDrawer> createState() =>
      _RecentActivityDrawerState();
}

class _RecentActivityDrawerState extends ConsumerState<RecentActivityDrawer> {
  final Set<String> hiddenEmails = {}; // Stores locally removed email IDs

  void _removeEmailFromDrawer(String emailRequestId) {
    setState(() {
      hiddenEmails.add(emailRequestId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailRequestsAsyncValue = ref.watch(emailRequestProvider);
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: emailRequestsAsyncValue.when(
                data: (emailRequests) {
                  final visibleEmails = emailRequests
                      .where((emailRequest) =>
                          !hiddenEmails.contains(emailRequest.id))
                      .toList();

                  if (visibleEmails.isEmpty) {
                    return const Center(
                        child: Text('No recent activities.',
                            style: TextStyle(fontSize: 16)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: visibleEmails.length,
                    itemBuilder: (context, index) {
                      final emailRequest = visibleEmails[index];
                      final recipientType =
                          (emailRequest.advisorEmail == user.wardenEmail)
                              ? 'Warden'
                              : 'Faculty Advisor';
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            title: Text(
                              recipientType,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  emailRequest.status,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 6),
                                CircleAvatar(
                                  radius: 6.0,
                                  backgroundColor:
                                      emailRequest.status == 'pending'
                                          ? Colors.orange
                                          : emailRequest.status == 'approved'
                                              ? Colors.green
                                              : Colors.red,
                                ),
                                const Spacer(),
                                Text(
                                  emailRequest.formattedDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (emailRequest.wardenEmail.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmailDetailPageWarden(
                                        emailRequest: emailRequest),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmailDetailPage(
                                      emailRequest: emailRequest,
                                      onRemove: _removeEmailFromDrawer,
                                    ),
                                  ),
                                );
                              }
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Remove from Recent Activity'),
                                    content: const Text(
                                        'Are you sure you want to remove this email from the recent activity list?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _removeEmailFromDrawer(
                                              emailRequest.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Remove',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
