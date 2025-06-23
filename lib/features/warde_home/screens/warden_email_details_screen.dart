import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WardenEmailDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  final String requestId;

  const WardenEmailDetailsScreen({
    required this.request,
    required this.requestId,
    super.key,
  });

  @override
  State<WardenEmailDetailsScreen> createState() => _WardenEmailDetailsScreenState();
}

class _WardenEmailDetailsScreenState extends State<WardenEmailDetailsScreen> {
  bool _actionTaken = false;

  Future<void> _updateRequestStatus(String status, {String? reason}) async {
    if (_actionTaken) return;

    setState(() {
      _actionTaken = true;
    });

    try {
      final updateData = {
        'status': status,
        if (reason != null) 'declineReason': reason,
      };

      await FirebaseFirestore.instance
          .collection('emailRequests')
          .doc(widget.requestId)
          .update(updateData);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(status == 'declined'
              ? 'Request declined with reason.'
              : 'Request approved successfully.'),
          backgroundColor: status == 'approved' ? Colors.green : Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );

      // Delay to let user see the snackbar, then pop
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _actionTaken = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update request status: $e')),
      );
    }
  }

  void _showDeclineReasonDialog() {
    final TextEditingController reasonController = TextEditingController();
    String? selectedReason;
    bool showManualInput = false;

    final predefinedReasons = [
      'Room not vacated properly',
      'Mess dues pending',
      'Improper documentation',
      'Violation of hostel rules',
      'Other',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Decline Reason',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedReason,
                  items: predefinedReasons
                      .map((reason) => DropdownMenuItem(
                            value: reason,
                            child: Text(reason),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value;
                      showManualInput = value == 'Other';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select a reason',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                if (showManualInput)
                  TextField(
                    controller: reasonController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Enter custom reason',
                      border: OutlineInputBorder(),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  String reason = '';

                  if (selectedReason == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a reason')),
                    );
                    return;
                  }

                  if (selectedReason == 'Other') {
                    reason = reasonController.text.trim();
                    if (reason.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter a custom reason')),
                      );
                      return;
                    }
                  } else {
                    reason = selectedReason!;
                  }

                  Navigator.pop(context); // Close dialog
                  _updateRequestStatus('declined', reason: reason);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Decline', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request['subject'] ?? 'No Subject',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    request['body'] ?? 'No Content Available',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _actionTaken
                            ? null
                            : () => _updateRequestStatus('approved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Accept',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      ElevatedButton(
                        onPressed:
                            _actionTaken ? null : () => _showDeclineReasonDialog(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Decline',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
