import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/on_boarding_page.dart';
import '../profile/complete_profile.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectedPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      selectedPage = controller.page?.round() ?? 1;
      setState(() {});
    });
  }

  List pageList = [
    {
      "title": "Track, Burn, and Achieve",
      "subtitle":
          "Empower yourself to reach your fitness goals by effortlessly tracking and burning calories",
      "image": "assets/images/on_1.png"
    },
    {
      "title": "Dream Big, Sleep Deep",
      "subtitle":
          "Say goodbye to restless nights and embrace rejuvenating sleep",
      "image": "assets/images/on_4.png"
    },
    {
      "title": "Calm Your Mind, Elevate Your Life",
      "subtitle":
          "In today's fast-paced world, prioritize mental wellness and discover tranquility amidst the chaos",
      "image": "assets/images/on_2.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColour.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageList.length,
            itemBuilder: (context, index) {
              var pObj = pageList[index] as Map? ?? {};
              return OnBoardingPage(
                pObj: pObj,
              );
            },
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColour.primaryColor1,
                    value: (selectedPage + 1) / pageList.length,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: TColour.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColour.white,
                    ),
                    color: TColour.primaryColor1,
                    onPressed: () {
                      if (selectedPage != 2) {
                        selectedPage += 1;
                        controller.jumpToPage(selectedPage);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteProfileView()));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
