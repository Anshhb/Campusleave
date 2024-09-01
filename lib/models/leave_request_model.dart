class LeaveRequest {
  final String id;
  final String studentName;
  final String studentEmail;
  final String date;
  final String status;

  LeaveRequest({
    required this.id,
    required this.studentName,
    required this.studentEmail,
    required this.date,
    required this.status,
  });

  factory LeaveRequest.fromMap(Map<String, dynamic> map, String id) {
    return LeaveRequest(
      id: id,
      studentName: map['studentName'] ?? '',
      studentEmail: map['studentEmail'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'studentEmail': studentEmail,
      'date': date,
      'status': status,
    };
  }
}
