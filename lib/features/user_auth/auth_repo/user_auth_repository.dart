import 'package:campusleave/core/constants/constants.dart';
import 'package:campusleave/core/constants/firebase_constants.dart';
import 'package:campusleave/core/failure.dart';
import 'package:campusleave/core/providers/firebase_providers.dart';
import 'package:campusleave/core/type_defs.dart';
import 'package:campusleave/features/user_auth/user_controller/user_auth_controller.dart';
import 'package:campusleave/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  FutureEither<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String rollNumber,
    // required Map<String, String> userDetails
    required dynamic userDetails,
    required String role,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // List<MapEntry<String, String>> entries = userDetails.entries.toList();
      // List<MapEntry<String, Map<String, String>> entries = userDetails.entries.toList();
      // // print(entries);
      // late String name;
      // for (var i = 0; i < entries.length; i++) {
      //   if(entries[i].key == rollNumber){
      //     name = entries[i].value;
      //     break;
      //   }
      // }
      late String name;
      late String faEmail;
      late String wardenEmail;
      if (role == 'student') {
        final userMap = userDetails[rollNumber];
        name = userMap['name'];
        faEmail = userMap['facultyAdvisorEmail'];
        wardenEmail = userMap['wardenEmail'];
      } else if (role == 'faculty') {
        for (var entries in userDetails.entries) {
          name = entries.key;
          faEmail = entries.value;
        }
        // name = userDetails.key();
        // faEmail = userDetails.value();
        wardenEmail = '';
        print("name: $name, faEmail: $faEmail, wardenemail: $wardenEmail");
      } else {
        for (var entries in userDetails.entries) {
          name = entries.key;
          wardenEmail = entries.value;
        }
        faEmail = '';
        print("name: $name, faEmail: $faEmail, wardenemail: $wardenEmail");
      }
      // late String name = "same"; // temporary

      // String role = 'student'; // Default role
      // if (userDetails.containsKey(rollNumber)) {
      //   role = 'student';
      // } else {
      //   return left(Failure('Roll number not found in records.'));
      // }

      UserModel userModel = UserModel(
        name: name,
        profilePic: Constants.avatarDefault,
        banner: Constants.bannerDefault,
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? "",
        role: role,
        faEmail: faEmail,
        wardenEmail: wardenEmail,
      );

      // await _users.doc(userModel.uid).set(userModel.toMap());
      // return right(userModel);
      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Future<User?> loginWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential.user;
  //   } catch (e) {
  //     throw Failure(e.toString());
  //   }
  // }

FutureEither<UserModel> loginWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Fetch user details from Firestore
    DocumentSnapshot userDoc = await _users.doc(userCredential.user!.uid).get();
    
    if (!userDoc.exists) {
      return left(Failure("User not found in database"));
    }

    UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

    return right(userModel);
  } on FirebaseAuthException catch (e) {
    return left(Failure(e.message!));
  } catch (e) {
    return left(Failure(e.toString()));
  }
}


  Stream<User?> get authStateChange => _auth.authStateChanges();

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  // void logOut() async {
  //   await _auth.signOut();
  // }
void logOut(WidgetRef ref, BuildContext context) async {
  await _auth.signOut(); // Sign out from Firebase

  // Reset userProvider to remove old user data
  ref.read(userProvider.notifier).update((state) => null);

  // Force UI update after logout
  if (context.mounted) {
    Routemaster.of(context).replace('/login'); // Navigate to login screen
  }
}

}
