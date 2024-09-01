class FacultyAdvisor {
  final String id;
  final String name;
  final String email;
  final String branch;
  final int year;

  FacultyAdvisor({
    required this.id,
    required this.name,
    required this.email,
    required this.branch,
    required this.year,
  });

  factory FacultyAdvisor.fromMap(Map<String, dynamic> map, String id) {
    return FacultyAdvisor(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      branch: map['branch'] ?? '',
      year: map['year'] is int ? map['year'] : int.parse(map['year']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'branch': branch,
      'year': year,
    };
  }
}
