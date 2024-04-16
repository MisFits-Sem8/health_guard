import 'package:flutter/material.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:health_app/services/auth_service.dart';

import '../../common/color_extension.dart';
import '../login/login.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome!",
              style: TextStyle(
                  color: TColour.black1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            RoundedButton(
              onPressed: () async {
                _auth.signOut;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ));
              },
              title: 'Sign Out',
            )
          ],
        ),
      ),
    );
  }
}
