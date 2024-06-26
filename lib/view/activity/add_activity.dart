// import 'package:fitness/view/sleep_tracker/sleep_schedule_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/today_sleep_schedule_row.dart';
import 'package:health_app/view/profile/profile_view.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  List todayWorkoutArray = [
    {
      "name": "Full Body",
      "image": "assets/images/meditation.png",
      "timestart": "04/28/2023 10:00 PM",
      "timeend": "04/28/2023 11:00 PM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Yoga",
      "image": "assets/images/yoga.png",
      "timestart": "04/28/2023 05:10 AM",
      "timeend": "04/28/2023 11:00 PM",
      "duration": "in 14hours 30minutes"
    },
  ];

  List<int> showingTooltipOnSpots = [4];
  String selectedName = 'Yoga'; // Default selection
  DateTime? selectedTime; // Placeholder for selected time

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _addScheduleItem() {
    if (selectedTime != null) {
      final now = DateTime.now();
      final duration = Duration(
        hours: selectedTime!.hour - now.hour,
        minutes: selectedTime!.minute - now.minute,
      );
      final formattedDuration = formatDuration(duration); // Calculate duration
      final workoutTypes = [
        'Full Body',
        'Cardio',
        'Yoga',
        'Strength',
        'Other'
      ];

      setState(() {
        todayWorkoutArray.add(
          {
            'name': selectedName,
            'image': selectedName == 'Full Body'
                ? 'assets/images/meditation.png'
                : (selectedName == 'Cardio'
                    ? 'assets/images/cardio.png' // Add breakfast image
                    : (selectedName == 'yoga'
                        ? 'assets/images/yoga.png' // Add lunch image
                        : (selectedName == 'Strength'
                            ? 'assets/images/strength.png' // Add dinner image
                            : 'assets/images/other_workout.png'))),
            'time': selectedTime!,
            'duration': formattedDuration,
          },
        );
        selectedTime = null; // Clear selection for next entry
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time first.'),
        ),
      );
    }
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    final String formattedHours = hours.toString().padLeft(2, '0');
    final String formattedMinutes = minutes.toString().padLeft(2, '0');

    return 'in $formattedHours hours $formattedMinutes minutes';
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final tooltipsOnBar = lineBarsData1[0];
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
        //     margin: const EdgeInsets.all(8),
        //     height: 40,
        //     width: 40,
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //         color: TColour.lightGray,
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Image.asset(
        //       "assets/images/icons/back-button.png",
        //       width: 15,
        //       height: 15,
        //       fit: BoxFit.contain,
        //     ),
        //   ),
        // ),
        title: Text(
          "Log your Activities",
          style: TextStyle(
              color: TColour.black1,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColour.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/profile-female.jpg",
                  height: media.width * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColour.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColour.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add your completed activity",
                                style: TextStyle(
                                    color: TColour.black1,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          Row(
                            children: [
                              // Dropdown to select name

                              DropdownButton<String>(
                                value: selectedName,
                                items: <DropdownMenuItem<String>>[
                                  DropdownMenuItem<String>(
                                    value: 'Full Body',
                                    child: Text('Full Body'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Cardio',
                                    child: Text('Cardio'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Yoga',
                                    child: Text('Yoga'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Strength',
                                    child: Text('Strength'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Other',
                                    child: Text('Other'),
                                  ),
                                ],
                                onChanged: (value) =>
                                    setState(() => selectedName = value!),
                              ),
                              // Button to select time
                              ElevatedButton(
                                onPressed: _selectTime,
                                child: const Text('Select Time'),
                              ),
                              SizedBox(
                                width: media.width * 0.04,
                              ),
                              // Button to add schedule
                              ElevatedButton(
                                onPressed: _addScheduleItem,
                                child: const Text('Add '),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Text(
                      "Completed Workouts",
                      style: TextStyle(
                          color: TColour.black1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.03,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: todayWorkoutArray.length,
                        itemBuilder: (context, index) {
                          var sObj = todayWorkoutArray[index] as Map? ?? {};
                          return TodaySleepScheduleRow(
                            sObj: sObj,
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColour.primaryColor2,
          TColour.primaryColor1,
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(colors: [
            TColour.primaryColor2,
            TColour.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        spots: const [
          FlSpot(1, 3),
          FlSpot(2, 5),
          FlSpot(3, 4),
          FlSpot(4, 7),
          FlSpot(5, 4),
          FlSpot(6, 8),
          FlSpot(7, 5),
        ],
      );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 2,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0h';
        break;
      case 2:
        text = '2h';
        break;
      case 4:
        text = '4h';
        break;
      case 6:
        text = '6h';
        break;
      case 8:
        text = '8h';
        break;
      case 10:
        text = '10h';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColour.gray,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColour.gray,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
