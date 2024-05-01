import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/db_helper/db_helper.dart';
import 'package:health_app/models/schedule.dart';
import 'package:health_app/services/notification_service.dart';

class TodaySleepScheduleRow extends StatefulWidget {
  final Map sObj;

  const TodaySleepScheduleRow({super.key, required this.sObj});

  @override
  State<TodaySleepScheduleRow> createState() => _TodaySleepScheduleRowState();
}

class _TodaySleepScheduleRowState extends State<TodaySleepScheduleRow> {
  FitnessDatabaseHelper databasehelper = FitnessDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: TColour.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                widget.sObj["image"].toString(),
                width: 40,
                height: 40,
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
                  Row(
                    children: [
                      Text(
                        widget.sObj["name"].toString(),
                        style: TextStyle(
                            color: TColour.black1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.sObj["time"].toString(),
                        style: TextStyle(
                          color: TColour.black1,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.sObj["duration"].toString(),
                    style: TextStyle(
                        color: TColour.gray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  child: Transform.scale(
                    scale: 0.7,
                    child: CustomAnimatedToggleSwitch<bool>(
                      current: widget.sObj["is_active"],
                      values: const [false, true],
                      spacing: 0.0,
                      indicatorSize: const Size.square(30.0),
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.linear,
                      iconsTappable: true,
                      onChanged: (b) async {
                        setState(() {
                          widget.sObj["is_active"] = !widget.sObj["is_active"];
                        });
                        databasehelper.updateSchedule(Schedule(
                            widget.sObj["id"],
                            widget.sObj["type"],
                            widget.sObj["time"],
                            widget.sObj["is_active"]));
                        if (!widget.sObj["is_active"]) {
                          await NotificationService()
                              .cancelNotification(widget.sObj["id"]);
                        } else {
                          await NotificationService().scheduleNotification(
                              widget.sObj["id"],
                              "Alert!",
                              "Don't miss your ${widget.sObj["type"]}",
                              widget.sObj["time"]);
                        }
                      },

                      iconBuilder: (context, local, global) {
                        return const SizedBox();
                      },
                      // defaultCursor: SystemMouseCursors.click,
                      // onTap: () => setState(() => positive = !positive),
                      // iconsTappable: false,
                      wrapperBuilder: (context, global, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                height: 30.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: TColour.secondary),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                )),
                            child,
                          ],
                        );
                      },
                      foregroundIndicatorBuilder: (context, global) {
                        return SizedBox.fromSize(
                          size: const Size(10, 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: TColour.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
