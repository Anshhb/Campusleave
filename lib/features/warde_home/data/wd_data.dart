import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addWardenMembers() async {
  final facultyCollection = FirebaseFirestore.instance.collection('warden');
  
  // List of faculty members to add
  final List<Map<String, dynamic>> wardenMembers = [
    {
      'name': 'dummy_warden',
      'email': 'wardendummy@gmail.com',
      'hostel': 'y3',
    },
  ];

  // Loop through each faculty member and check if they already exist
  for (var warden in wardenMembers) {
    final email = warden['email'] as String;
    final querySnapshot = await facultyCollection.where('email', isEqualTo: email).get();

    // If the faculty member doesn't exist, add them
    if (querySnapshot.docs.isEmpty) {
      await facultyCollection.add(warden);
    }
  }
}
