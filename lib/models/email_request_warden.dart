// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class EmailRequestWarden {
//   final String id;
//   final String userId;
//   final String wardenId;
//   final String wardenEmail;
//   final String subject;
//   final String body;
//   final String status; // 'pending', 'approved', 'declined'
//   final Timestamp timestamp;

//   EmailRequestWarden({
//     required this.id,
//     required this.userId,
//     required this.wardenId,
//     required this.wardenEmail,
//     required this.subject,
//     required this.body,
//     required this.status,
//     required this.timestamp,
//   });

//   factory EmailRequestWarden.fromMap(Map<String, dynamic> map, String id) {
//     return EmailRequestWarden(
//       id: id,
//       userId: map['userId'] ?? '',
//       wardenId: map['wardenId'] ?? '',
//       wardenEmail: map['wardenEmail'] ?? '',
//       subject: map['subject'] ?? '',
//       body: map['body'] ?? '',
//       status: map['status'] ?? 'pending',
//       timestamp: map['timestamp'] ?? Timestamp.now(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'wardenId': wardenId,
//       'wardenEmail': wardenEmail,
//       'subject': subject,
//       'body': body,
//       'status': status,
//       'timestamp': timestamp,
//     };
//   }


//   String get formattedDate {
//     return DateFormat('dd-MM-yy').format(timestamp.toDate());
//   }
// }
