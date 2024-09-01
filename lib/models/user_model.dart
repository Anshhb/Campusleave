// class UserModel {
//   final String name;
//   final String profilePic;
//   final String banner;
//   final String uid;
//   final String email; // Add this line

//   UserModel({
//     required this.name,
//     required this.profilePic,
//     required this.banner,
//     required this.uid,
//     required this.email, // Add this line
//   });

//   UserModel copyWith({
//     String? name,
//     String? profilePic,
//     String? banner,
//     String? uid,
//     String? email, // Add this line
//   }) {
//     return UserModel(
//       name: name ?? this.name,
//       profilePic: profilePic ?? this.profilePic,
//       banner: banner ?? this.banner,
//       uid: uid ?? this.uid,
//       email: email ?? this.email, // Add this line
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'profilePic': profilePic,
//       'banner': banner,
//       'uid': uid,
//       'email': email, // Add this line
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       name: map['name'] ?? '',
//       profilePic: map['profilePic'] ?? '',
//       banner: map['banner'] ?? '',
//       uid: map['uid'] ?? '',
//       email: map['email'] ?? '', // Add this line
//     );
//   }

//   @override
//   String toString() {
//     return 'UserModel(name: $name, profilePic: $profilePic, banner: $banner, uid: $uid, email: $email)'; // Add email here
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is UserModel &&
//         other.name == name &&
//         other.profilePic == profilePic &&
//         other.banner == banner &&
//         other.uid == uid &&
//         other.email == email; // Add this line
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//         profilePic.hashCode ^
//         banner.hashCode ^
//         uid.hashCode ^
//         email.hashCode; // Add this line
//   }
// }


// 2nd 

import 'package:campusleave/core/constants/constants.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profilePic;
  final String banner;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.banner,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? Constants.avatarDefault,
      banner: map['banner'] ?? Constants.bannerDefault,
      role: map['role'] ?? 'student', // Default to 'student' if not provided
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'banner': banner,
      'role': role,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? profilePic,
    String? banner,
    String? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      role: role ?? this.role,
    );
  }
}
