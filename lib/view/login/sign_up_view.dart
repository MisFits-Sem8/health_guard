import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:health_app/common_widgets/rounded_text_field.dart';
import 'package:health_app/services/auth_service.dart';
import 'package:health_app/view/login/login.dart';
import '../on_boarding/on_boarding_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();

  bool isVisible = true;
  bool isCheck = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColour.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
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
                  height: media.height * 0.015,
                ),
                RoundTextField(
                  controller: _name,
                  hintText: "Name",
                  iconName: Icons.person,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: media.height * 0.015,
                ),
                RoundTextField(
                  hintText: "Email",
                  controller: _email,
                  iconName: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: media.height * 0.015,
                ),
                RoundTextField(
                  hintText: "Password",
                  controller: _password,
                  obscureText: isVisible,
                  iconName: Icons.password,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
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
                  height: media.height * 0.001,
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
                  height: media.height * 0.02,
                ),
                RoundedButton(
                  title: "Register",
                  onPressed: _signup,
                ),
                SizedBox(
                  height: media.height * 0.02,
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
                  height: media.height * 0.001,
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
      ),
    );
  }

  _signup() async {
    if (!isCheck) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'You must agree to the privacy and policies before signing up.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      String? errorMessage = await _auth.createUserWithEmailAndPassword(
          _email.text, _password.text, _name.text);
      if (EmailValidator.validate(errorMessage!)) {
        if (mounted) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const CompleteProfileView()));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const OnBoardingView()));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Oh! Snap",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
            ),
          ));
        }
      }
    }
  }
}
