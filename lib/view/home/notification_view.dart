import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/data/models/user_model.dart';
import 'package:health_app/data/repository/authentication_repository.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

final userRepo = Get.put(AuthenticationRepository());

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
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: TColour.lightGray,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/images/icons/back-button.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                )),
          ),
          title: Text(
            "Notification",
            style: TextStyle(
                color: TColour.black1,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: TColour.lightGray,
                      borderRadius: BorderRadius.circular(10)),
                  // child:Icon(Icons.arrow_back_ios ,color:TColour.white,),
                  child: Image.asset(
                    "assets/images/icons/more.png",
                    width: 12,
                    height: 12,
                    fit: BoxFit.contain,
                  )),
            ),
          ],
        ),
        backgroundColor: TColour.white,
        body: ListView.separated(
            itemBuilder: ((context, index) {
              var nObj = notifications[index] as Map? ?? {};
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                            fontSize: 12,
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
                          width: 30,
                          height: 30,
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
