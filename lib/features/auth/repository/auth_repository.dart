// // import 'package:campusleave/core/constants/constants.dart';
// // import 'package:campusleave/core/constants/firebase_constants.dart';
// // import 'package:campusleave/core/failure.dart';
// // import 'package:campusleave/core/providers/firebase_providers.dart';
// // import 'package:campusleave/core/type_defs.dart';
// // import 'package:campusleave/models/user_model.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:fpdart/fpdart.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// // final authRepositoryProvider = Provider(
// //   (ref) => AuthRepository(
// //     firestore: ref.read(firestoreProvider),
// //     auth: ref.read(authProvider),
// //     googleSignIn: ref.read(googleSignInProvider),
// //   ),
// // );

// // class AuthRepository {
// //   final FirebaseFirestore _firestore;
// //   final FirebaseAuth _auth;
// //   final GoogleSignIn _googleSignIn;

// //   AuthRepository({
// //     required FirebaseFirestore firestore,
// //     required FirebaseAuth auth,
// //     required GoogleSignIn googleSignIn,
// //   })  : _auth = auth,
// //         _firestore = firestore,
// //         _googleSignIn = googleSignIn;

// //   CollectionReference get _users =>
// //       _firestore.collection(FirebaseConstants.userCollection);

// //   FutureEither<UserModel> signInWithGoogle() async {
// //     try {
// //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

// //       final googleAuth = await googleUser?.authentication;
// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth?.accessToken,
// //         idToken: googleAuth?.idToken,
// //       );

// //       UserCredential userCredential =
// //           await _auth.signInWithCredential(credential);
// //       late UserModel userModel;

// //       if (userCredential.additionalUserInfo!.isNewUser) {
// //         userModel = UserModel(
// //           name: userCredential.user!.displayName ?? 'No Name',
// //           profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
// //           banner: Constants.bannerDefault,
// //           uid: userCredential.user!.uid,
// //         );
// //         await _users.doc(userCredential.user!.uid).set(userModel.toMap());
// //       }
// //       return right(userModel);
// //     } on FirebaseException catch(e){
// //       throw e.message!;
// //     } catch (e) {
// //       return left(Failure(e.toString()));
// //     }
// //   }
// // }

//2nd

// import 'package:campusleave/core/constants/constants.dart';
// import 'package:campusleave/core/constants/firebase_constants.dart';
// import 'package:campusleave/core/failure.dart';
// import 'package:campusleave/core/providers/firebase_providers.dart';
// import 'package:campusleave/core/type_defs.dart';
// import 'package:campusleave/models/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart'; // Add this import
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final authRepositoryProvider = Provider(
//   (ref) => AuthRepository(
//     firestore: ref.read(firestoreProvider),
//     auth: ref.read(authProvider),
//     googleSignIn: ref.read(googleSignInProvider),
//   ),
// );

// class AuthRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   final GoogleSignIn _googleSignIn;

//   AuthRepository({
//     required FirebaseFirestore firestore,
//     required FirebaseAuth auth,
//     required GoogleSignIn googleSignIn,
//   })  : _auth = auth,
//         _firestore = firestore,
//         _googleSignIn = googleSignIn;

//   CollectionReference get _users =>
//       _firestore.collection(FirebaseConstants.userCollection);

//   Stream<User?> get authStateChange => _auth.authStateChanges();

//   FutureEither<UserModel> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in process
//         return left(Failure("Sign-in cancelled by user"));
//       }

//       final googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential userCredential =
//           await _auth.signInWithCredential(credential);

//       final String? email = userCredential.user?.email;
//       if (email != null && email.endsWith('@iitj.ac.in')) {
//         UserModel userModel;

//         if (userCredential.additionalUserInfo!.isNewUser) {
//           userModel = UserModel(
//             name: userCredential.user!.displayName ?? 'No Name',
//             profilePic:
//                 userCredential.user!.photoURL ?? Constants.avatarDefault,
//             banner: Constants.bannerDefault,
//             uid: userCredential.user!.uid,
//             email: userCredential.user!.email??"",
//           );
//           await _users.doc(userCredential.user!.uid).set(userModel.toMap());
//         } else {
//           userModel = await getUserData(userCredential.user!.uid).first;
//         }
//         return right(userModel);
//       } else {
//         // Sign out if the email domain is not allowed
//         await _auth.signOut();
//         await _googleSignIn.signOut();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text(
//                   'Only @iitj.ac.in email accounts are allowed to sign in.')),
//         );
//         return left(
//             Failure('Only @iitj.ac.in email accounts are allowed to sign in.'));
//       }
//     } on FirebaseException catch (e) {
//       return left(Failure(e.message!));
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }

//   Stream<UserModel> getUserData(String uid) {
//     return _users.doc(uid).snapshots().map(
//           (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
//         );
//   }

//   void logOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }


// 3rd
 

// import 'package:campusleave/core/constants/constants.dart';
// import 'package:campusleave/core/constants/firebase_constants.dart';
// import 'package:campusleave/core/failure.dart';
// import 'package:campusleave/core/providers/firebase_providers.dart';
// import 'package:campusleave/core/type_defs.dart';
// import 'package:campusleave/models/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final authRepositoryProvider = Provider(
//   (ref) => AuthRepository(
//     firestore: ref.read(firestoreProvider),
//     auth: ref.read(authProvider),
//     googleSignIn: ref.read(googleSignInProvider),
//   ),
// );

// class AuthRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   final GoogleSignIn _googleSignIn;

//   AuthRepository({
//     required FirebaseFirestore firestore,
//     required FirebaseAuth auth,
//     required GoogleSignIn googleSignIn,
//   })  : _auth = auth,
//         _firestore = firestore,
//         _googleSignIn = googleSignIn;

//   CollectionReference get _users =>
//       _firestore.collection(FirebaseConstants.userCollection);

//   Stream<User?> get authStateChange => _auth.authStateChanges();

// FutureEither<UserModel> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     if (googleUser == null) {
//       return left(Failure("Sign-in cancelled by user"));
//     }

//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     UserCredential userCredential = await _auth.signInWithCredential(credential);

//     final String? email = userCredential.user?.email;
//     if (email != null && email.endsWith('@iitj.ac.in')) {
//       UserModel userModel;
//       String role = 'student'; // Default role

//       // Check if the email belongs to a faculty advisor
//       final facultySnapshot = await _firestore
//           .collection('faculty')
//           .where('email', isEqualTo: email)
//           .get();

//       if (facultySnapshot.docs.isNotEmpty) {
//         role = 'faculty';
//       }

//       if (userCredential.additionalUserInfo!.isNewUser) {
//         userModel = UserModel(
//           name: userCredential.user!.displayName ?? 'No Name',
//           profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
//           banner: Constants.bannerDefault,
//           uid: userCredential.user!.uid,
//           email: userCredential.user!.email ?? "",
//           role: role,
//         );
//         await _users.doc(userCredential.user!.uid).set(userModel.toMap());
//       } else {
//         userModel = await getUserData(userCredential.user!.uid).first;
//         // Update the role if it's different (in case the role is not set or changed)
//         if (userModel.role != role) {
//           userModel = userModel.copyWith(role: role);
//           await _users.doc(userModel.uid).update(userModel.toMap());
//         }
//       }
//       return right(userModel);
//     } else {
//       await _auth.signOut();
//       await _googleSignIn.signOut();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Only @iitj.ac.in email accounts are allowed to sign in.')),
//       );
//       return left(Failure('Only @iitj.ac.in email accounts are allowed to sign in.'));
//     }
//   } on FirebaseException catch (e) {
//     return left(Failure(e.message!));
//   } catch (e) {
//     return left(Failure(e.toString()));
//   }
// }

//   Stream<UserModel> getUserData(String uid) {
//     return _users.doc(uid).snapshots().map(
//           (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
//         );
//   }

//   void logOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }

//4th temporary

import 'package:campusleave/core/constants/constants.dart';
import 'package:campusleave/core/constants/firebase_constants.dart';
import 'package:campusleave/core/failure.dart';
import 'package:campusleave/core/providers/firebase_providers.dart';
import 'package:campusleave/core/type_defs.dart';
import 'package:campusleave/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(Failure("Sign-in cancelled by user"));
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      final String? email = userCredential.user?.email;
      if (email != null) {
        UserModel userModel;
        String role = 'student'; // Default role

        // Check if the email belongs to a faculty advisor
        final facultySnapshot = await _firestore
            .collection('faculty')
            .where('email', isEqualTo: email)
            .get();

        // Check if the email belongs to a faculty advisor
        final wardenSnapshot = await _firestore
            .collection('warden')
            .where('email', isEqualTo: email)
            .get();

        if (facultySnapshot.docs.isNotEmpty) {
          role = 'faculty';
        }
        if (wardenSnapshot.docs.isNotEmpty) {
          role = 'warden';
        }

        if (userCredential.additionalUserInfo!.isNewUser) {
          userModel = UserModel(
            name: userCredential.user!.displayName ?? 'No Name',
            profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
            banner: Constants.bannerDefault,
            uid: userCredential.user!.uid,
            email: userCredential.user!.email ?? "",
            role: role,
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toMap());
        } else {
          DocumentSnapshot userDoc = await _users.doc(userCredential.user!.uid).get();
          if (userDoc.exists && userDoc.data() != null) {
            userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
            // Update the role if it's different (in case the role is not set or changed)
            if (userModel.role != role) {
              userModel = userModel.copyWith(role: role);
              await _users.doc(userModel.uid).update(userModel.toMap());
            }
          } else {
            // Handle the case where the user document does not exist or is null
            userModel = UserModel(
              name: userCredential.user!.displayName ?? 'No Name',
              profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
              banner: Constants.bannerDefault,
              uid: userCredential.user!.uid,
              email: userCredential.user!.email ?? "",
              role: role,
            );
            await _users.doc(userCredential.user!.uid).set(userModel.toMap());
          }
        }
        return right(userModel);
      } else {
        return left(Failure('Email not found.'));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
