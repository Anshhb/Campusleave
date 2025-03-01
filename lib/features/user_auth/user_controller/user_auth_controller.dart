// import 'package:campusleave/core/utils/utils.dart';
// import 'package:campusleave/features/auth/user_auth/auth_repo/user_auth_repository.dart';
// import 'package:campusleave/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);

// final authControllerProvider = StateNotifierProvider<AuthController, bool>(
//   (ref) => AuthController(
//     authRepository: ref.watch(authRepositoryProvider),
//     ref: ref,
//   ),
// );

// final authStateChangeProvider = StreamProvider((ref) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.authStateChange;
// });

// final getUserDataProvider = StreamProvider.family((ref, String uid) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.getUserdata(uid);
// });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository _authRepository;
//   final Ref _ref;

//   AuthController({required AuthRepository authRepository, required Ref ref})
//       : _authRepository = authRepository,
//         _ref = ref,
//         super(false);

//   Stream<User?> get authStateChange => _authRepository.authStateChange;

//   Future<void> signUpWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String rollNumber,
//     required Map<String, String> userDetails,
//     required BuildContext context,
//   }) async {
//     state = true;
//     final user = await _authRepository.signUpWithEmailAndPassword(
//       email: email,
//       password: password,
//       rollNumber: rollNumber,
//       userDetails: userDetails,
//       context: context,
//     );
//     state = false;
//     user.fold(
//       (l) => showSnackBar(context, l.message),
//       (userModel) =>
//           _ref.read(userProvider.notifier).update((state) => userModel),
//     );
//   }

//   Future<void> loginWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     await _authRepository.loginWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Stream<UserModel> getUserdata(String uid) {
//     return _authRepository.getUserData(uid);
//   }

//   void logOut() async {
//     _authRepository.logOut();
//   }
// }

import 'package:campusleave/core/utils/utils.dart';
import 'package:campusleave/features/user_auth/auth_repo/user_auth_repository.dart';
import 'package:campusleave/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String rollNumber,
    required BuildContext context,
    // required Map<String, String> userDetails,
    required dynamic userDetails,
    required String role,
  }) async {
    state = true; // Loading state
    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      rollNumber: rollNumber,
      userDetails: userDetails,
      context: context,
      role: role,
    );
    state = false; // End loading

    result.fold(
      (failure) => showSnackBar(context, failure.message),
      (userModel) {
        _ref.read(userProvider.notifier).state = userModel;
        showSnackBar(context, 'Signup successful! Welcome, ${userModel.name}');
      },
    );
  }

  // void loginWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     state = true; // Loading state
  //     final user = await _authRepository.loginWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     state = false; // End loading

  //     if (user != null) {
  //       showSnackBar(context, 'Login successful!');
  //       final userData = await getUserData(user.uid).first;
  //       _ref.read(userProvider.notifier).state = userData;
  //     }
  //   } catch (e) {
  //     state = false;
  //     showSnackBar(context, e.toString());
  //   }
  // }
  void loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // Loading state

    final result = await _authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    state = false; // End loading

    result.fold(
      (failure) {
        showSnackBar(context, failure.message);
      },
      (userModel) {
        _ref.read(userProvider.notifier).state = userModel;
        showSnackBar(context, "Login successful! Welcome, ${userModel.name}");

        // Navigate to home page (adjust as per your routing setup)

        if (userModel.role == 'student') {
          // print("in this block!!!");
          Routemaster.of(context).replace('/');
        } else if (userModel.role == 'faculty') {
          // print("in facult block!!!");
          Routemaster.of(context).replace('/');
        } else if (userModel.role == 'warden') {
          // print("in warden block!!!");          
          Routemaster.of(context).replace('/');
        } else {
          showSnackBar(context, "Some error occured!");
        }
      },
    );
  }

  void logout(WidgetRef ref, BuildContext context) async {
    _authRepository.logOut(ref, context);
    // _ref.read(userProvider.notifier).state = null;
  }
}
