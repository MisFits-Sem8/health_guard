import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:http/http.dart' as http;
import '../../common/color_extension.dart';
import '../profile/profile_view.dart';

class MentalHealthSummary extends StatefulWidget {
  final String gender;
  const MentalHealthSummary({Key? key,
    required this.gender,})
      : super(key: key);

  @override
  State<MentalHealthSummary> createState() => _MentalHealthSummaryState();
}

class _MentalHealthSummaryState extends State<MentalHealthSummary> {
  String selectedDay = "Mon"; // Default selected day

  List<String> daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String selectedFeeling = "Happy"; // Default feeling
  String selectedEmoji = "😊";
  String prompt = "initial";
  List<Map<String, String>> emotion = [
    {"emoji": "😊", "name": "Happy"},
    {"emoji": "😞", "name": "Sad"},
    {"emoji": "😡", "name": "Angry"},
    {"emoji": "😄", "name": "Excited"},
    {"emoji": "😬", "name": "Anxious"},
    {"emoji": "😌", "name": "Relaxed"},
    {"emoji": "🤔", "name": "Confused"},
    {"emoji": "😌", "name": "Content"},
    {"emoji": "😤", "name": "Frustrated"},
    {"emoji": "😑", "name": "Bored"},
    {"emoji": "😮", "name": "Surprised"},
    {"emoji": "🙏", "name": "Grateful"},
    {"emoji": "🤞", "name": "Hopeful"},
    {"emoji": "🎉", "name": "Enthusiastic"},
    {"emoji": "😍", "name": "In love"},
  ];
  List<dynamic> depressionStatus = [
    {"moderate": 0.681951642036438},
    {"not depression": 0.3168366253376007},
    {"severe": 0.0012117630103603005}
  ];

  TextEditingController feelingController = TextEditingController();
  String selectedSleepingStatus = 'Asleep';
  String selectedStressLevel = 'Low';
  TimeOfDay selectedSleepTime = TimeOfDay(hour: 0, minute: 0);
  String label1 = '';
  double score1 = 0.0;
  String label2 = '';
  double score2 = 0.0;
  String label3 = '';
  double score3 = 0.0;

  bool display = false;
  void updateData(List<dynamic> responseData) {
    print('updated');
    print(responseData[0][0]['score']);
    setState(() {
      label1 = responseData[0][0]['label'];
      score1 = responseData[0][0]['score'];
      label2 = responseData[0][1]['label'];
      score2 = responseData[0][1]['score'];
      label3 = responseData[0][2]['label'];
      score3 = responseData[0][2]['score'];
    });
  }

  String url = "https://flask-chat.vercel.app/assess";
  Future<List<dynamic>> sendPostRequest() async {
    print("in the method");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "sleeping_status": selectedSleepingStatus,
          "feeling_text": feelingController.text,
          "emotion": selectedFeeling,
          "stress_level": selectedStressLevel,
        }));

    if (response.statusCode == 200) {
      var out = json.decode(response.body);
      prompt = out['prompt'];

      var depressionStatus = out["depression_status"];

      print(prompt);
      print(depressionStatus);
      updateData(depressionStatus);
      display = true;
      return depressionStatus;
    } else {
      throw Exception('Failed to load prompt');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var data;

    String output = 'Initial Output';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColour.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mental Health Assessment",
          style: TextStyle(
              color: TColour.black1, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            },
            icon: ClipOval(
              child: Image.asset(
                widget.gender == "female" ? "assets/images/profile-female.jpg" : "assets/images/profile-male.png",
                height: media.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'How do you feel today?',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      children: emotion.map((emotion) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedFeeling = emotion["name"]!;
                                selectedEmoji = emotion["emoji"]!;
                              });
                            },
                            child: Tooltip(
                              message: emotion["name"],
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow:
                                        selectedFeeling == emotion["name"]
                                            ? [
                                                BoxShadow(
                                                  color: TColour.secondaryColor2
                                                      .withOpacity(0.9),
                                                  blurRadius: 30,
                                                  spreadRadius: 2,
                                                ),
                                              ]
                                            : null,
                                  ),
                                  child: Center(
                                    child: MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          // Change text style when hovered
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          // Reset text style when not hovered
                                        });
                                      },
                                      child: Text(
                                        emotion["emoji"]!,
                                        style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'You are feeling ${selectedFeeling.isNotEmpty ? selectedFeeling : "None"} ${selectedEmoji.isNotEmpty ? selectedEmoji : "None"}',
                      style:
                          TextStyle(fontSize: 15, color: TColour.lightTextGray),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            const Center(
              child: Text(
                'Tell something about your feelings...',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: TColour.lightGray,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8)
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                  controller: feelingController,
                  decoration: const InputDecoration(
                      hintText: 'Say something...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0)),
                  style: TextStyle(color: TColour.gray),
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {
                      feelingController.text = value;
                    });
                  }),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sleep level',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                            color: TColour.lightGray,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 8)
                            ]),
                        child: DropdownButton(
                          underline: SizedBox(),
                          style: TextStyle(
                            color: TColour.primaryColor1,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          dropdownColor: TColour.lightGray,
                          value: selectedSleepingStatus,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: <String>[
                            'Asleep',
                            'Napping',
                            'Restless',
                            'Dreaming',
                            // Add more sleeping statuses as needed
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Container(
                                width: media.width * 0.3,
                                alignment:
                                    Alignment.center, // Align text to center
                                color: TColour
                                    .lightGray, // Non-selected item color
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectedSleepingStatus == value
                                        ? TColour
                                            .primaryColor1 // Text color for selected item
                                        : Colors
                                            .black, // Text color for non-selected item
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSleepingStatus = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Stress level',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: TColour.lightGray,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 8)
                          ],
                        ),
                        child: DropdownButton(
                          underline: SizedBox(),
                          style: TextStyle(
                            color: TColour.primaryColor1,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          dropdownColor: TColour.lightGray,
                          value: selectedStressLevel,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: <String>[
                            'Low', 'Moderate', 'High', 'Chronic',
                            // Add more sleeping statuses as needed
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Container(
                                width: media.width * 0.3,
                                alignment:
                                    Alignment.center, // Align text to center
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectedStressLevel == value
                                        ? TColour
                                            .primaryColor1 // Text color for selected item
                                        : Colors
                                            .black, // Text color for non-selected item
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStressLevel = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Container(
              alignment: Alignment.center,
              child: RoundedButton(
                onPressed: () async {
                  data = await sendPostRequest();
                  setState(() {
                    updateData(data);
                    _generateSections();
                    depressionStatus = data;
                  });
                },
                title: "Submit",
                type: RoundButtonType.bgGradient,
              ),
            ),
            SizedBox(height: 30.0),
            Visibility(
                visible: display, // Show the PieChart only when display is true
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                    color: TColour.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(3.0),
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: _generateSections(),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                    ),
                  ),
                )))
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    List<PieChartSectionData> sections = [];
    print("in pi chart");

    sections.add(
      PieChartSectionData(
        color: _getColorForStatus(label1),
        value: score1 * 10000, // Convert score to percentage
        title:
            '${(score1 * 100).toStringAsFixed(1)}\n${label1}%', // Display percentage
        radius: 30,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: TColour.black3,
        ),
      ),
    );
    sections.add(
      PieChartSectionData(
        color: _getColorForStatus(label2),
        value: score2 * 10000, // Convert score to percentage
        title:
            '${(score2 * 100).toStringAsFixed(1)}%\n${label2}', // Display percentage
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: TColour.black3,
        ),
      ),
    );
    sections.add(
      PieChartSectionData(
        color: _getColorForStatus(label3),
        value: score3 * 10000, // Convert score to percentage
        title:
            '${(score3 * 100).toStringAsFixed(1)}%\n${label3}', // Display percentage
        radius: 40,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: TColour.black3,
        ),
      ),
    );
    print(sections);

    return sections;
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case "moderate":
        return Colors.blueAccent;
      case "not depression":
        return Colors.green;
      case "severe":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
