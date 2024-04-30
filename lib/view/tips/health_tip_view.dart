import "dart:math";
import "package:flutter/material.dart";
import "../../common/color_extension.dart";
import "../../models/user.dart";
import "../../services/auth_service.dart";
import "../bottom_tab/bottom_tab.dart";

List healthTips = [
  {
    "title": "Stay Hydrated",
    "subtitle":
        "Drink plenty of water throughout the day to keep your body hydrated and functioning optimally. Carry a reusable water bottle with you as a reminder to sip regularly.",
    "image": "assets/images/tip-1.png"
  },
  {
    "title": "Move Every Day",
    "subtitle":
        "Incorporate physical activity into your daily routine, whether it's a brisk walk, yoga session, or dance class. Aim for at least 30 minutes of moderate exercise most days of the week to boost your mood and energy levels.",
    "image": "assets/images/tip-2.png"
  },
  {
    "title": "Eat Mindfully",
    "subtitle":
        "Pay attention to what you eat and how it makes you feel. Opt for whole, nutrient-rich foods like fruits, vegetables, lean proteins, and whole grains. Practice mindful eating by savoring each bite and listening to your body's hunger and fullness cues.",
    "image": "assets/images/tip-3.png"
  },
  {
    "title": "Prioritize Sleep",
    "subtitle":
        "Make quality sleep a priority by establishing a consistent bedtime routine and creating a restful sleep environment. Aim for 7-9 hours of sleep per night to support overall health and well-being.",
    "image": "assets/images/tip-4.png"
  },
  {
    "title": "Manage Stress",
    "subtitle":
        "Find healthy ways to cope with stress, such as meditation, deep breathing exercises, or spending time in nature. Prioritize self-care activities that bring you joy and relaxation to help reduce the negative effects of stress on your body and mind.",
    "image": "assets/images/tip-5.png"
  }
];

class HealthTipPage extends StatelessWidget {
  const HealthTipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final random = Random();
    final selectedTipIndex = random.nextInt(healthTips.length);
    final selectedTip = healthTips[selectedTipIndex];

    return Scaffold(
      backgroundColor: TColour.white,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: media.width,
              height: media.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            // Fetch user data
                            _initializeUserData(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Health Habit of the Day for Vibrant Living",
                      style: TextStyle(
                        color: TColour.black1,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      selectedTip["title"],
                      style: TextStyle(
                          color: TColour.black2,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      selectedTip["subtitle"],
                      style: TextStyle(
                          color: TColour.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    selectedTip["image"],
                    width: media.width,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeUserData(BuildContext context) async {
    final AuthService _auth = AuthService();
    UserDataModel? userData = await _auth.getUserData();
    if (userData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomTab(
            height: userData.height,
            weight: userData.weight,
            workout: userData.workout,
            name: userData.name,
            sleep: userData.sleep,
            gender: userData.gender,
            age: userData.age,
            targetWaterIntake: (userData.water * 1000).toInt(),
            bmiScore: calculateBMI(userData.height, userData.weight),
          ),
        ),
      );
    } else {
      print("User data is not available.");
    }
  }

  double calculateBMI(int height, int weight) {
    double heightInMeters = height / 100.0;
    return double.parse(
        (weight / (heightInMeters * heightInMeters)).toStringAsFixed(1));
  }
}
