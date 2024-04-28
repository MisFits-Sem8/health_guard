import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';

import '../profile/profile_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

// ignore: camel_case_types
class _NotificationViewState extends State<NotificationView> {
  List notifications = [
    {
      "image": "assets/images/diet_boy.webp",
      "title": "New diet plan available now!",
      "time": "2024-04-09 10:00 AM",
      "didView": true
    },
    {
      "image": "assets/images/diet_girl.jpeg",
      "title": "Try our healthy recipes!",
      "time": "2024-04-09 11:30 AM",
      "didView": false
    },
    {
      "image": "assets/images/diet_girl.jpeg",
      "title": "Get fit with our workout tips!",
      "time": "2024-04-09 12:45 PM",
      "didView": true
    },
    {
      "image": "assets/images/diet_girl.jpeg",
      "title": "Don't miss today's nutrition advice!",
      "time": "2024-04-09 2:15 PM",
      "didView": false
    },
    {
      "image": "assets/images/workout_girl.jpg",
      "title": "Join our fitness challenge!",
      "time": "2024-04-09 3:30 PM",
      "didView": true
    },
    {
      "image": "assets/images/workout_boy.jpg",
      "title": "Discover new workout routines!",
      "time": "2024-04-09 5:00 PM",
      "didView": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TColour.white,
          centerTitle: true,
          elevation: 0,
          // leading: InkWell(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: Container(
          //       width: 40,
          //       height: 40,
          //       margin: const EdgeInsets.all(8),
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //           color: TColour.lightGray,
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Image.asset(
          //         "assets/images/icons/back-button.png",
          //         width: 20,
          //         height: 20,
          //         fit: BoxFit.contain,
          //       )),
          // ),
          title: Text(
            "Notification",
            style: TextStyle(
                color: TColour.black1,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileView()));
                },
                icon: Image.asset(
                  "assets/images/profile-female.jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
        backgroundColor: TColour.white,
        body: ListView.separated(
            itemBuilder: ((context, index) {
              var nObj = notifications[index] as Map? ?? {};
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        nObj["image"].toString(),
                        width: 60,
                        height: 60,
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
                          nObj["title"].toString(),
                          style: TextStyle(
                            color: TColour.black1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          nObj["time"].toString(),
                          style: TextStyle(
                            color: TColour.primaryColor1,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            notifications.removeAt(index);
                          });
                        },
                        icon: Image.asset(
                          "assets/images/icons/trash.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ))
                  ],
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return Divider(
                color: TColour.primaryColor2.withOpacity(.5),
                height: 1,
              );
            },
            itemCount: notifications.length));
  }
}
