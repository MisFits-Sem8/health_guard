import "package:flutter/material.dart";
import "package:health_app/common_widgets/goal_card.dart";
import "package:health_app/common_widgets/rounded_btn.dart";
import "package:health_app/view/profile/edit_profile_view.dart";

import "../../common/color_extension.dart";
import "../../common_widgets/title_subtitle.dart";
import "../../services/auth_service.dart";
import "../login/login.dart";
import "complete_profile.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Gender gender = Gender.female;
  String name = "Kumuthu Athukorala";
  double sleep = 6;
  double workout = 2;
  double water = 2.5;
  int height = 180;
  int weight = 50;
  int age = 25;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColour.white,
        centerTitle: true,
        elevation: 0,
        // leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColour.black1, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColour.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      gender == Gender.female
                          ? "assets/images/profile-female.jpg"
                          : "assets/images/profile-male.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: TColour.black1,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          gender == Gender.female ? "Her/She" : "He/Him",
                          style: TextStyle(
                            color: TColour.gray,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundedButton(
                      title: "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileView(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColour.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Details",
                      style: TextStyle(
                        color: TColour.black1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TitleSubtitleCell(
                            title: "${height}cm",
                            subtitle: "Height",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TitleSubtitleCell(
                            title: "${weight}cm",
                            subtitle: "Weight",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TitleSubtitleCell(
                            title: "${age}yo",
                            subtitle: "Age",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: TColour.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Goals",
                          style: TextStyle(
                            color: TColour.black1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GoalCard(
                          goalname: 'Sleep',
                          target: sleep.toString(),
                          unit: "hrs",
                          imageName: "sleep",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GoalCard(
                          goalname: 'Workout',
                          target: workout.toString(),
                          imageName: "workout",
                          unit: 'hrs',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GoalCard(
                          goalname: 'Water',
                          target: water.toString(),
                          imageName: "water",
                          unit: 'litres',
                        )
                      ])),
              const SizedBox(
                height: 20,
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
                title: 'Log Out',
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 5),
              const Text(
                '© 2024 HealthGuard. All rights reserved.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
