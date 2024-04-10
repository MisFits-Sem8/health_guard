import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/activity/activity_view.dart';
import 'package:health_app/view/login/google_sign_in.dart';
import 'package:health_app/view/home/notification_view.dart';
import 'package:health_app/view/login/sign_up_view.dart';
import 'package:health_app/view/on_boarding/getting_started_view.dart';
import 'package:health_app/view/on_boarding/on_boarding_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repository/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // int local storage
  await GetStorage.init();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then(
  //       (FirebaseApp value) => Get.put(AuthenticationRepository()),
  // );
  // await splash until other items load
  // FlutterNativeSplash.preserve(widgetsBinding:widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Guard',
      theme: ThemeData(
        primaryColor: TColour.primaryColor1,
        fontFamily: "Poppins",
        useMaterial3: true,
      ),
      home: const Google_sign_in(),
    );
  }
}
