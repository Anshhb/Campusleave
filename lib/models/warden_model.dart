class WardenModel {
  final String id;
  final String name;
  final String email;
  final String hostel;


  WardenModel({
    required this.id,
    required this.name,
    required this.email,
    required this.hostel,

  });

  factory WardenModel.fromMap(Map<String, dynamic> map, String id) {
    return WardenModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      hostel: map['hostel'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hostel': hostel,
      
    };
  }
}
