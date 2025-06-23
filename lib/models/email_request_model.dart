

  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

  class EmailRequest {
    final String id;
    final String userId;
    final String advisorId;
    final String advisorEmail;
    final String wardenId;
    final String wardenEmail;
    final String subject;
    final String body;
    final String status; // 'pending', 'approved', 'declined'
    final Timestamp timestamp;
    final String? declineReason; // ✅ New field

    EmailRequest({
      required this.id,
      required this.userId,
      this.advisorId = '',
      this.advisorEmail = '',
      this.wardenId = '',
      this.wardenEmail = '',
      required this.subject,
      required this.body,
      required this.status,
      required this.timestamp,
      this.declineReason,
    });

    factory EmailRequest.fromMap(Map<String, dynamic> map, String id) {
      return EmailRequest(
        id: id,
        userId: map['userId'] ?? '',
        advisorId: map['advisorId'] ?? '',
        advisorEmail: map['advisorEmail'] ?? '',
        wardenId: map['wardenId'] ?? '',
        wardenEmail: map['wardenEmail'] ?? '',
        subject: map['subject'] ?? '',
        body: map['body'] ?? '',
        status: map['status'] ?? 'pending',
        timestamp: map['timestamp'] ?? Timestamp.now(),
        declineReason: map['declineReason'], // ✅ New
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'userId': userId,
        'advisorId': advisorId,
        'advisorEmail': advisorEmail,
        'wardenId': wardenId,
        'wardenEmail': wardenEmail,
        'subject': subject,
        'body': body,
        'status': status,
        'timestamp': timestamp,
        'declineReason': declineReason, // ✅ New
      };
    }

    String get formattedDate {
      return DateFormat('dd-MM-yy').format(timestamp.toDate());
    }
  }
