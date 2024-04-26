import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

class MentalHealthSummary extends StatefulWidget {
  const MentalHealthSummary({super.key});

  @override
  State<MentalHealthSummary> createState() => _MentalHealthSummaryState();
}

class _MentalHealthSummaryState extends State<MentalHealthSummary> {
  String selectedDay = "Mon"; // Default selected day

  List<String> daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String selectedFeeling = "😐"; // Default feeling
  TextEditingController feelingController = TextEditingController();
  String selectedSleepingStatus = 'Asleep';
  String selectedStressLevel = 'Low';
  TimeOfDay selectedSleepTime = TimeOfDay(hour: 0, minute: 0);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Your Mental Health'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Day',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: daysOfWeek
                  .map(
                    (day) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            gradient: selectedDay == day
                                ? LinearGradient(colors: TColour.primary)
                                : LinearGradient(colors: TColour.secondary),
                            // color: selectedDay == day ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: selectedDay == day
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'How do you feel today?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  color: TColour.primaryColor1.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFeeling = "😄"; // Happy
                      });
                    },
                    child: Text('😄', style: TextStyle(fontSize: 40.0)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFeeling = "😐"; // Neutral
                      });
                    },
                    child: Text('😐', style: TextStyle(fontSize: 40.0)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFeeling = "😢"; // Sad
                      });
                    },
                    child: Text('😢', style: TextStyle(fontSize: 40.0)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFeeling = "😢"; // Sad
                      });
                    },
                    child: Text('😢', style: TextStyle(fontSize: 40.0)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Tell something about your feelings..',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: TColour.primary,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: feelingController,
                decoration: InputDecoration(
                    hintText: 'How do you feel?',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
                style: TextStyle(color: Colors.white),
                maxLines: 5,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sleeping Status',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: TColour.primary,
                          ),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 7)
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSleepingStatus,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSleepingStatus = newValue!;
                            });
                          },
                          items: <String>[
                            'Asleep',
                            'Napping',
                            'Restless',
                            'Dreaming',
                            // Add more sleeping statuses as needed
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                alignment:
                                    Alignment.center, // Align text to center
                                color: selectedSleepingStatus == value
                                    ? TColour
                                        .primaryColor1 // Selected item color
                                    : TColour
                                        .primaryColor2, // Non-selected item color
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectedSleepingStatus == value
                                        ? Colors
                                            .white // Text color for selected item
                                        : Colors
                                            .black, // Text color for non-selected item
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ), // Add more widgets as needed
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sleeping Status',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      DropdownButton(
                        // Initial Value
                        style: TextStyle(
                          color: TColour.primaryColor1,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,

                        ),
                        dropdownColor: TColour.primaryColor2,
                        value: selectedStressLevel,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: <String>[
                          'Low', 'Moderate', 'High', 'Chronic',
                          // Add more sleeping statuses as needed
                        ].map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),

                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStressLevel = newValue!;
                          });
                        },
                      ),
                      Container(
                        width: media.width * .3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: TColour.primary,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton<String>(
                          value: selectedStressLevel,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStressLevel = newValue!;
                            });
                          },
                          items: <String>[
                            'Low', 'Moderate', 'High', 'Chronic',
                            // Add more sleeping statuses as needed
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                alignment:
                                    Alignment.center, // Align text to center
                                color: selectedStressLevel == value
                                    ? TColour
                                        .primaryColor1 // Selected item color
                                    : TColour
                                        .primaryColor2, // Non-selected item color
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: selectedStressLevel == value
                                        ? Colors
                                            .white // Text color for selected item
                                        : Colors
                                            .black, // Text color for non-selected item
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ), // Add more widgets as needed
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            GestureDetector(
              onTap: () {
                // _selectTime(context);
              },
              child: Text(
                '${selectedSleepTime.format(context)}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              // padding: const EdgeInsets.all(20),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Handle submission logic here
              },
              child: Text(
                'Submit',
              ), // Add a child widget (e.g., Text) for the button label
            ),

            //
            //   ),
          ],
        ),
      ),
    );
  }
}
