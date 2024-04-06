import 'package:flutter/material.dart';
import 'package:health_app/view/home/home.dart';
import 'package:health_app/view/login/sign_up_view.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/rounded_btn.dart';
import '../../common_widgets/rounded_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isVisible = true;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColour.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Hey there,",
                style: TextStyle(color: TColour.gray, fontSize: 15),
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(
                    color: TColour.black1,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: media.height * 0.05,
              ),
              const RoundTextField(
                hintText: "Email",
                iconName: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: media.height * 0.03,
              ),
              RoundTextField(
                hintText: "Password",
                obscureText: isVisible,
                iconName: Icons.password,
                keyboardType: TextInputType.visiblePassword,
                rightIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Icon(
                      isVisible ? Icons.remove_red_eye : Icons.hide_source),
                ),
              ),
              SizedBox(
                height: media.height * 0.08,
              ),
              RoundedButton(
                  title: "Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                    );
                  }),
              SizedBox(
                height: media.height * 0.02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                          color: TColour.black1,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          color: TColour.black1,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
