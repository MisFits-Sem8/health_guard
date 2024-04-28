import 'package:flutter/material.dart';
import 'package:health_app/view/activity/activity_view.dart';
import 'package:health_app/view/home/home.dart';
import 'package:health_app/view/message/message_view.dart';
import 'package:health_app/view/notifications/notifications_view.dart';
import 'package:health_app/view/profile/complete_profile.dart';
import 'package:health_app/view/profile/profile_view.dart';

import '../../common/color_extension.dart';
import '../../common_widgets/tab_button.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int selectedTab = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: PageStorage(bucket: pageStorageBucket, child: currentTab),
      bottomNavigationBar: BottomAppBar(
        height: media.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
              iconData: Icons.home_rounded,
              isActive: selectedTab == 0,
              onTap: () {
                selectedTab = 0;
                currentTab = const HomeView();
                if (mounted) {
                  setState(() {});
                }
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.directions_run_rounded,
              isActive: selectedTab == 1,
              onTap: () {
                selectedTab = 1;
                currentTab = const ActivityView();
                if (mounted) {
                  setState(() {});
                }
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.notifications_rounded,
              isActive: selectedTab == 2,
              onTap: () {
                selectedTab = 2;
                currentTab = const CompleteProfileView();
                if (mounted) {
                  setState(() {});
                }
              },
              size: media.height * 0.04,
            ),
            TabButton(
              iconData: Icons.message_rounded,
              isActive: selectedTab == 3,
              onTap: () {
                selectedTab = 3;
                currentTab = const MessageView();
                if (mounted) {
                  setState(() {});
                }
              },
              size: media.height * 0.039,
            ),TabButton(
              iconData: Icons.person_2_rounded,
              isActive: selectedTab == 4,
              onTap: () {
                selectedTab = 4;
                currentTab = const ProfileView();
                if (mounted) {
                  setState(() {});
                }
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
