import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/create_schdeuls/create_schedule_view.dart';
import 'package:health_app/view/on_boarding/getting_started_view.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
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
        home:const SleepTrackerView());
        // home: const GettingStartedView());
  }
}
