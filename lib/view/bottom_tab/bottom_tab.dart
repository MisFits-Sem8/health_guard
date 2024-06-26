import 'package:flutter/material.dart';
import 'package:health_app/view/activity/activity_view.dart';
import 'package:health_app/view/activity/mental_health_summary.dart';
import 'package:health_app/view/create_schdeuls/create_schedule_view.dart';
import 'package:health_app/view/message/message_view.dart';
import 'package:health_app/view/notifications/notifications_view.dart';
import 'package:health_app/view/profile/profile_view.dart';
import '../../common/color_extension.dart';
import '../../common_widgets/tab_button.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../message/message.dart';

class BottomTab extends StatefulWidget {
  String gender;
  String name;
  int height;
  int weight;
  int age;
  double sleep;
  double workout;
  int targetWaterIntake;
  double bmiScore;
  BottomTab(
      {Key? key,
      required this.height,
      required this.weight,
      required this.workout,
      required this.name,
      required this.sleep,
      required this.gender,
      required this.age,
      required this.targetWaterIntake,
      required this.bmiScore})
      : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int selectedTab = 0;
  List<Message> messages = [];
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final AuthService _auth = AuthService();

  Future<void> _initializeUserData() async {
    UserDataModel? userData = await _auth.getUserData();
    if (userData != null) {
      setState(() {
        widget.name = userData.name;
        widget.height = userData.height;
        widget.weight = userData.weight;
        widget.age = userData.age;
        widget.gender = userData.gender;
        widget.sleep = userData.sleep;
        widget.workout = userData.workout;
        widget.targetWaterIntake = (userData.water * 1000).toInt();
        double heightInMeters = widget.height / 100.0;
        widget.bmiScore = double.parse(
            (widget.weight / (heightInMeters * heightInMeters))
                .toStringAsFixed(1));
      });
    } else {
      print("User data is not available.");
    }
  }

  Future<void> _loadMessages() async {
    List<Message> loadedMessages = await _auth.getUserMessages();
    setState(() {
      messages = loadedMessages;
    });
  }

  late Widget currentTab; // Declare currentTab as late Widget

  @override
  void initState() {
    super.initState();
    currentTab = ActivityView(
      height: widget.height,
      weight: widget.weight,
      workout: widget.workout,
      name: widget.name,
      sleep: widget.sleep,
      gender: widget.gender,
      age: widget.age,
      targetWaterIntake: widget.targetWaterIntake,
      bmiScore: widget.bmiScore,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currentTab,
      ),
      bottomNavigationBar: BottomAppBar(
        height: media.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
              iconData: Icons.home_rounded,
              isActive: selectedTab == 0,
              onTap: () {
                setState(() {
                  selectedTab = 0;
                  _initializeUserData();
                  currentTab = ActivityView(
                    height: widget.height,
                    weight: widget.weight,
                    workout: widget.workout,
                    name: widget.name,
                    sleep: widget.sleep,
                    gender: widget.gender,
                    age: widget.age,
                    targetWaterIntake: widget.targetWaterIntake,
                    bmiScore: widget.bmiScore,
                  );
                });
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.calendar_month_rounded,
              isActive: selectedTab == 1,
              onTap: () {
                setState(() {
                  selectedTab = 1;
                  currentTab = CreateScheduleView(gender: widget.gender);
                });
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.emoji_emotions_rounded,
              isActive: selectedTab == 2,
              onTap: () {
                setState(() {
                  selectedTab = 2;
                  currentTab = MentalHealthSummary(gender: widget.gender,);
                });
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.message_rounded,
              isActive: selectedTab == 3,
              onTap: () {
                setState(() {
                  selectedTab = 3;
                  _loadMessages();
                  currentTab = MessageView(
                    messages: messages,
                  );
                });
              },
              size: media.height * 0.039,
            ),
            TabButton(
              iconData: Icons.person_2,
              isActive: selectedTab == 4,
              onTap: () {
                setState(() {
                  selectedTab = 4;
                  currentTab = const ProfileView();
                });
              },
              size: media.height * 0.04,
            )
          ],
        ),
      ),
      backgroundColor: TColour.white,
    );
  }
}
