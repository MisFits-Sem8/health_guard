import "package:flutter/material.dart";
import "package:health_app/common_widgets/goal_card.dart";
import "package:health_app/common_widgets/rounded_btn.dart";
import "package:health_app/view/profile/edit_profile_view.dart";
import "../../common/color_extension.dart";
import "../../common_widgets/title_subtitle.dart";
import "../../models/user.dart";
import "../../services/auth_service.dart";
import "../login/login.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String? id = "";
  late String gender = "";
  late String name = "";
  late int height = 0;
  late int weight = 0;
  late int age = 0;
  late double sleep = 0;
  late double workout = 0;
  late double water = 0;
  final AuthService _auth = AuthService();

  Future<void> _initializeUserData() async {
    UserDataModel? userData = await _auth.getUserData();
    if (userData != null) {
      setState(() {
        id = userData.id;
        name = userData.name;
        height = userData.height;
        weight = userData.weight;
        age = userData.age;
        gender = userData.gender;
        sleep = userData.sleep;
        workout = userData.workout;
        water = userData.water;
      });
    } else {
      print("User data is not available.");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColour.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColour.black1, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColour.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        gender == "female"
                            ? "assets/images/profile-female.jpg"
                            : "assets/images/profile-male.png",
                        height: media.width * 0.15,
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
                            gender == "female" ? "She/Her" : "He/Him",
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
                              builder: (context) => EditProfileView(
                                age: age,
                                height: height,
                                weight: weight,
                                gender: gender,
                                water: water,
                                sleep: sleep,
                                workout: workout,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.1,
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
                SizedBox(
                  height: media.width * 0.1,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
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
                SizedBox(
                  height: media.width * 0.1,
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
                SizedBox(
                  height: media.width * 0.05,
                ),
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
      ),
    );
  }
}
