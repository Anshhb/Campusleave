import 'package:campusleave/features/warden/warden_data/warden_data.dart';
import 'package:flutter/material.dart';

class WardenSelectionScreen extends StatelessWidget {
  const WardenSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Warden'),
      ),
      body: ListView.builder(
        itemCount: warden.length,
        itemBuilder: (context, index) {
          final wardenn = warden[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                wardenn.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                wardenn.hostel,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  wardenn.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pop(wardenn);
              },
            ),
          );
        },
      ),
    );
  }
}