import 'package:flutter/material.dart';
import 'package:campusleave/models/email_request_model.dart';

class EmailDetailPage extends StatefulWidget {
  final EmailRequest emailRequest;
  final Function(String requestId) onRemove;

  const EmailDetailPage({
    super.key,
    required this.emailRequest,
    required this.onRemove,
  });

  @override
  State<EmailDetailPage> createState() => _EmailDetailPageState();
}

class _EmailDetailPageState extends State<EmailDetailPage> {
  void _removeFromRecentActivity() {
    widget.onRemove(widget.emailRequest.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.emailRequest.status;
    final isDeclined = status == 'declined';
    final reason = widget.emailRequest.toMap()['declineReason'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Details'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Remove from Recent Activity'),
                  content: const Text(
                    'Are you sure you want to remove this email from recent activity?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _removeFromRecentActivity();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Remove',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To: ${widget.emailRequest.advisorEmail}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Subject: ${widget.emailRequest.subject}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Chip(
                      label: Text(
                        status.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: status == 'approved'
                          ? Colors.green
                          : status == 'pending'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ],
                ),
                if (isDeclined && reason != null && reason.trim().isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reason for Rejection:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          reason,
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                const Divider(thickness: 1.2),
                const SizedBox(height: 12),
                const Text(
                  'Body:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.emailRequest.body,
                  style: const TextStyle(fontSize: 15.0, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
