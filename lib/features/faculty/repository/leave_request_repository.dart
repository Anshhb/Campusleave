import 'package:campusleave/models/leave_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leaveRequestRepositoryProvider = Provider((ref) {
  return LeaveRequestRepository(firestore: FirebaseFirestore.instance);
});

final leaveRequestsProvider = FutureProvider<List<LeaveRequest>>((ref) {
  return ref.watch(leaveRequestRepositoryProvider).getLeaveRequests();
});

class LeaveRequestRepository {
  final FirebaseFirestore _firestore;

  LeaveRequestRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> updateLeaveRequestStatus(String id, String status) async {
    try {
      await _firestore
          .collection('leaveRequests')
          .doc(id)
          .update({'status': status});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<LeaveRequest>> getLeaveRequests() async {
    try {
      final snapshot = await _firestore.collection('leaveRequests').get();
      return snapshot.docs
          .map((doc) => LeaveRequest.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
