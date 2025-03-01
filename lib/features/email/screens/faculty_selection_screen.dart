// // import 'package:campusleave/features/email/FA_data/fa_data.dart';
// // import 'package:flutter/material.dart';

// // class FacultySelectionScreen extends StatelessWidget {
// //   const FacultySelectionScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Select Faculty Advisor'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: facultyAdvisors.length,
// //         itemBuilder: (context, index) {
// //           final advisor = facultyAdvisors[index];
// //           return Card(
// //             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
// //             child: ListTile(
// //               title: Text(
// //                 advisor.name,
// //                 style: const TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 18.0,
// //                 ),
// //               ),
// //               subtitle: Text(
// //                 '${advisor.branch} ${advisor.year}',
// //                 style: const TextStyle(
// //                   fontSize: 14.0,
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //               leading: CircleAvatar(
// //                 backgroundColor: Theme.of(context).primaryColor,
// //                 child: Text(
// //                   advisor.name[0],
// //                   style: const TextStyle(color: Colors.white),
// //                 ),
// //               ),
// //               trailing: const Icon(Icons.arrow_forward_ios),
// //               onTap: () {
// //                 Navigator.of(context).pop(advisor);
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }


// import 'package:campusleave/features/email/screens/send_email.dart';
// import 'package:flutter/material.dart';
// import 'package:campusleave/features/email/FA_data/fa_data.dart';

// class FacultySelectionScreen extends StatelessWidget {
//   const FacultySelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Faculty Advisor'),
//       ),
//       body: ListView.builder(
//         itemCount: facultyAdvisors.length,
//         itemBuilder: (context, index) {
//           final advisor = facultyAdvisors[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: ListTile(
//               title: Text(
//                 advisor.name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               subtitle: Text(
//                 '${advisor.branch} ${advisor.year}',
//                 style: const TextStyle(
//                   fontSize: 14.0,
//                   color: Colors.grey,
//                 ),
//               ),
//               leading: CircleAvatar(
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: Text(
//                   advisor.name[0],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 // Navigate to the new SendEmailScreen when an advisor is selected
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SendEmailScreen(
//                       advisor: advisor, // Pass the selected advisor's email
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
