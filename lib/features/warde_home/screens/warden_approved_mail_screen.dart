import 'package:campusleave/features/auth/controller/auth_controller.dart';
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
        title: const Text('Approved Mails'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emailRequests')
            .where('wardenEmail', isEqualTo: ref.read(userProvider)?.email)
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No approved requests found.'));
          }

          return _buildRequestsList(context, snapshot.data!.docs);
        },
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
                    builder: (_) => WardenEmailReadOnlyScreen(request: request),
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