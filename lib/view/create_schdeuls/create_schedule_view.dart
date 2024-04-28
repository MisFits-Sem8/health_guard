import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/today_sleep_schedule_row.dart';
import 'package:health_app/view/profile/profile_view.dart';

class CreateScheduleView extends StatefulWidget {
  const CreateScheduleView({super.key});

  @override
  State<CreateScheduleView> createState() => _CreateScheduleViewState();
}

class _CreateScheduleViewState extends State<CreateScheduleView> {
  List todaySleepArr = [
    {
      "name": "Bedtime",
      "image": "assets/images/bed.png",
      "time": "04/28/2023 11:00 PM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Medical",
      "image": "assets/images/medical.png",
      "time": "04/28/2023 05:10 AM",
      "duration": "in 14hours 30minutes"
    },
    {
      "name": "Workout",
      "image": "assets/images/workout.png",
      "time": "04/28/2023 05:00 PM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Meditation",
      "image": "assets/images/meditation.png",
      "time": "04/28/2023 05:10 AM",
      "duration": "in 14hours 30minutes"
    },
    {
      "name": "Breakfast",
      "image": "assets/images/breakfast.png",
      "time": "04/28/2023 09:00 AM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Lunch",
      "image": "assets/images/lunch.png",
      "time": "04/28/2023 01:10 pM",
      "duration": "in 14hours 30minutes"
    },
    {
      "name": "Dinner",
      "image": "assets/images/dinner.png",
      "time": "04/28/2023 08:10 PM",
      "duration": "in 14hours 30minutes"
    },
  ];

  List findEatArr = [
    {
      "name": "Breakfast",
      "image": "assets/images/m_3.png",
      "number": "120+ Foods"
    },
    {"name": "Lunch", "image": "assets/images/m_4.png", "number": "130+ Foods"},
  ];

  List<int> showingTooltipOnSpots = [4];
  String selectedName = 'Bedtime'; // Default selection
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

      setState(() {
        todaySleepArr.add(
          {
            'name': selectedName,
            'image': selectedName == 'Bedtime'
                ? 'assets/images/bed.png'
                : (selectedName == 'Breakfast'
                    ? 'assets/images/breakfast.png' // Add breakfast image
                    : (selectedName == 'Lunch'
                        ? 'assets/images/lunch.png' // Add lunch image
                        : (selectedName == 'Dinner'
                            ? 'assets/images/dinner.png' // Add dinner image
                            : (selectedName == 'Workout'
                                ? 'assets/images/workout1.png'
                                : (selectedName == 'Medical'
                                    ? 'assets/images/medical.png' // Add workout image
                                    : (selectedName == 'Meditation'
                                        ? 'assets/images/meditation.png' // Add meditation image
                                        : 'assets/images/alaarm.png')))))),
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
        title: Text(
          "Create your own schedules",
          style: TextStyle(
              color: TColour.black1, fontSize: 16, fontWeight: FontWeight.w700),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              "New Schedule Create",
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
                                  value: 'Bedtime',
                                  child: Text('Bedtime'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Alarm',
                                  child: Text('Alarm'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Breakfast',
                                  child: Text('Breakfast'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Lunch',
                                  child: Text('Lunch'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Dinner',
                                  child: Text('Dinner'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Workout',
                                  child: Text('Workout'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Meditation',
                                  child: Text('Meditation'),
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
                    "Available Schedules",
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
                      itemCount: todaySleepArr.length,
                      itemBuilder: (context, index) {
                        var sObj = todaySleepArr[index] as Map? ?? {};
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
