import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/view/on_boarding/getting_started_view.dart';

void main() {
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
      home: const GettingStartedView(),
    );
  }
}
