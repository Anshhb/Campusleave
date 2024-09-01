import 'package:campusleave/core/providers/firebase_providers.dart';
import 'package:campusleave/models/faculty_advisor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final facultyAdvisorRepositoryProvider = Provider((ref) {
  return FacultyAdvisorRepository(firestore: ref.watch(firestoreProvider));
});

class FacultyAdvisorRepository {
  final FirebaseFirestore _firestore;
  FacultyAdvisorRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _facultyAdvisors =>
      _firestore.collection('facultyAdvisors');

  Future<List<FacultyAdvisor>> getFacultyAdvisors() async {
    try {
      final snapshot = await _facultyAdvisors.get();
      return snapshot.docs
          .map((doc) => FacultyAdvisor.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
