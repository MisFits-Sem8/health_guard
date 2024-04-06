import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:health_app/common_widgets/rounded_text_field.dart';
import 'package:health_app/view/login/complete_profile.dart';
import 'package:health_app/view/login/login.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isVisible = true;
  bool isCheck = false;
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
                "Create an Account",
                style: TextStyle(
                    color: TColour.black1,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              const RoundTextField(
                hintText: "Name",
                iconName: Icons.person,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              const RoundTextField(
                hintText: "Email",
                iconName: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: media.height * 0.02,
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
                height: media.height * 0.005,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isCheck = !isCheck;
                  });
                },
                child: Row(
                  children: [
                    Icon(isCheck
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "I've read and agree to the privacy and policies",
                        style: TextStyle(fontSize: 12, color: TColour.gray),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: media.height * 0.03,
              ),
              RoundedButton(
                  title: "Register",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompleteProfileView()));
                  }),
              SizedBox(
                height: media.height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: TColour.gray,
                    ),
                  ),
                  Text(
                    "Or",
                    style: TextStyle(
                      color: TColour.gray,
                      fontSize: 13,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: TColour.gray,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: TColour.black1,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Log in",
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
