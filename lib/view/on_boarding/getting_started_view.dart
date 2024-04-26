import "package:flutter/material.dart";
import "package:health_app/common/color_extension.dart";
import "../../common_widgets/rounded_btn.dart";
import "../login/login.dart";

class GettingStartedView extends StatefulWidget {
  const GettingStartedView({super.key});

  @override
  State<GettingStartedView> createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColour.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: TColour.primary,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "HealthGuard",
              style: TextStyle(
                  color: TColour.black2,
                  fontSize: 36,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Unlock Your Best Self: From Restful Sleep to Active Days, We've Got You Covered!",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: TColour.white,
                ),
              ),
            ),
            const Spacer(),
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RoundedButton(
                    type: RoundButtonType.textGradient,
                    title: 'Get Started',
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const OnBoardingView()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ));
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
