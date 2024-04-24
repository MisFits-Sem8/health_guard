import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:health_app/view/bottom_tab/bottom_tab.dart';
import 'package:health_app/view/login/sign_up_view.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/rounded_btn.dart';
import '../../common_widgets/rounded_text_field.dart';
import '../../services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  var isVisible = true;
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
                  "Welcome Back!",
                  style: TextStyle(
                      color: TColour.black1,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.height * 0.05,
                ),
                RoundTextField(
                  hintText: "Email",
                  iconName: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
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
                  height: media.height * 0.03,
                ),
                RoundTextField(
                  hintText: "Password",
                  obscureText: isVisible,
                  iconName: Icons.password,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _password,
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
                  height: media.height * 0.08,
                ),
                RoundedButton(title: "Login", onPressed: _login),
                SizedBox(
                  height: media.height * 0.02,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpView(),
                      ),
                    );
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
      ),
    );
  }

  _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? errorMessage = await _auth.loginUserWithEmailAndPassword(
          _email.text, _password.text);
      if (EmailValidator.validate(errorMessage!)) {
        if (mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BottomTab()));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            ),
          );
        }
      }
    }
  }
}
