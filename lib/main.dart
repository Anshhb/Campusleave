import 'package:campusleave/core/common/error_text.dart';
import 'package:campusleave/core/common/loader.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/features/faculty/data/faculty_data.dart';
import 'package:campusleave/features/warde_home/data/wd_data.dart';
import 'package:campusleave/firebase_options.dart';
import 'package:campusleave/models/user_model.dart';
import 'package:campusleave/router.dart';
import 'package:campusleave/theme/pallerte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  addFacultyMembers();
  addWardenMembers();
  await dotenv.load();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserdata(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'campusleave',
            theme: Pallete.lightModeAppTheme,
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    if (userModel!.role == 'faculty') {
                      return facultyLoggedInRoute;
                    }
                    else if (userModel!.role == 'warden') {
                      return wardenLoggedInRoute;
                    }
                     else {
                      return loggedInRoute;
                    }
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
