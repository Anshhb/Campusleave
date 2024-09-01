import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFacultyMembers() async {
  final facultyCollection = FirebaseFirestore.instance.collection('faculty');
  
  // List of faculty members to add
  final List<Map<String, dynamic>> facultyMembers = [
    {
      'name': 'dummy_fa',
      'email': 'dummyfa3@gmail.com',
      'branch': 'mechanical',
      'year': '2022',
    },
  ];

  // Loop through each faculty member and check if they already exist
  for (var faculty in facultyMembers) {
    final email = faculty['email'] as String;
    final querySnapshot = await facultyCollection.where('email', isEqualTo: email).get();

    // If the faculty member doesn't exist, add them
    if (querySnapshot.docs.isEmpty) {
      await facultyCollection.add(faculty);
    }
  }
}
