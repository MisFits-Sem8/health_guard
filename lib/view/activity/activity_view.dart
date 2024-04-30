import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:health_app/view/activity/add_activity.dart';
import 'package:health_app/view/activity_summary/sleep_tracker_view.dart';
import 'package:health_app/view/profile/edit_profile_view.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:health_app/model/daily_steps.dart';
import 'package:health_app/db_helper/db_helper.dart';
import 'package:health_app/repositories/data_repository.dart';
import '../profile/profile_view.dart';

class ActivityView extends StatefulWidget {
  String gender;
  String name;
  int height;
  int weight;
  int age;
  double sleep;
  double workout;
  int targetWaterIntake;
  double bmiScore;
  ActivityView(
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
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  late Stream<StepCount> _stepCountStream;

  late Stream<PedestrianStatus> _pedestrianStatusStream;

  String _status = '?', _steps = '?';

  List<FlSpot> allSpots = [];

  // Map<String, DailySteps> stepRecords = {};

  final FitnessDatabaseHelper databaseHelper = FitnessDatabaseHelper();

  List<int> tools = [];

  DateTime _currentDay = DateTime.now();

  int _dailySteps = 0;

  double previousSteps = 0;

  final DataRepository _dataRepository = DataRepository();

  void setBmiInterpretation() {
    if (widget.bmiScore > 30) {
      bmiStatus = "OBESITY";
      bmiInterpretation = "Do workout. ";
      bmiStatusColor = Colors.orange.shade900;
    } else if (widget.bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise.";
      bmiStatusColor = Colors.orange.shade500;
    } else if (widget.bmiScore >= 18.5) {
      bmiStatus = "NORMAL";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.lightGreen.shade800;
    } else if (widget.bmiScore < 18.5) {
      bmiStatus = "UNDERWEIGHT";
      bmiInterpretation = "Increase the weight.";
      bmiStatusColor = Colors.blueAccent.shade400;
    }
  }

  List waterArray = [
    {"title": "6-8", "subtitle": "1 cup"},
    {"title": "8-10", "subtitle": "2 cup"},
    {"title": "10-12", "subtitle": "3 cup"},
    {"title": "12-14", "subtitle": "1 cup"}
  ];


  @override
  void initState() {
    // _initializeUserData();
    super.initState();
    initPlatformState();
    updateStepsView();
  }

  void onStepCount(StepCount event) {
    setState(() {
      if (!allSpots.isNotEmpty || previousSteps == 0) {
        previousSteps = event.steps.toDouble();
      }

      String eventDate = DateFormat('yyyy-MM-dd').format(event.timeStamp);
      String currentDate = DateFormat('yyyy-MM-dd').format(_currentDay);

      // Check if the current day is the same as the last recorded day
      if (eventDate == currentDate) {
        // If it's the same day, increment the daily steps
        _dailySteps += (event.steps - previousSteps).toInt();
        // previousSteps = event.steps.toDouble();
      } else {
        // If it's a new day, reset the daily steps and update the current day
        _dailySteps = (event.steps - previousSteps).toInt();
        _currentDay = event.timeStamp;
      }
      previousSteps = event.steps.toDouble();
      // Update the steps display
      _steps = _dailySteps.toString();

      // print("_steps");
      debugPrint(_steps);

      if (allSpots.isNotEmpty &&
          _dataRepository
                  .recordSteps[_dataRepository.recordSteps.length - 1]?.date ==
              eventDate) {
        // print(eventDate);
        // print(_dataRepository.recordSteps[allSpots.last.x.toInt()]);

        // Update the last entry if it's for the current day
        allSpots[_dataRepository.recordSteps.length - 1] = FlSpot(
            _dataRepository.recordSteps.length - 1, _dailySteps.toDouble());

        DailySteps? prevRecord =
            _dataRepository.recordSteps[_dataRepository.recordSteps.length - 1];
        if (prevRecord != null) {
          prevRecord.updateSteps(_dailySteps);
          // _dataRepository.updateStep(allSpots.last.x.toInt(), prevRecord);
        } else {
          _dataRepository.updateStep(_dataRepository.recordSteps.length - 1,
              DailySteps(eventDate, _dailySteps));
        }
        // _dataRepository.updateStep(allSpots.last.x.toInt(), prevRecord);
      } else {
        // Add a new entry for the new day
        allSpots.add(FlSpot(_dataRepository.recordSteps.length.toDouble(),
            _dailySteps.toDouble()));
        tools.add(_dataRepository.recordSteps.length);
        _dataRepository.updateStep(_dataRepository.recordSteps.length,
            DailySteps(eventDate, _dailySteps));
      }
      // print(_dataRepository);
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    // print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    // print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    // print(_status);
  }

  void onStepCountError(error) {
    // print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void updateStepsView() async {
    await databaseHelper.initializeDatabase();
    List<DailySteps> recordSteps = await databaseHelper.getStepsList();

    // Create a new list to store the filtered spots
    List<FlSpot> filteredSpots = [];

    for (int i = 0; i < recordSteps.length; i++) {
      _dataRepository.updateStep(i, recordSteps[i]);
    }
    debugPrint("organized");
    debugPrint(_dataRepository.toString());

    for (int i = 0; i < _dataRepository.recordSteps.length; i++) {
      if (_dataRepository.recordSteps.containsKey(i)) {
        // DailySteps step = _dataRepository.recordSteps[i]!;
        DailySteps step = _dataRepository.recordSteps[i]!;
        String currentDate = DateFormat('yyyy-MM-dd').format(_currentDay);
        debugPrint("dates");
        debugPrint(step.date);
        // Check if the current day is the same as the last recorded day
        if (step.date == currentDate) {
          _dailySteps += step.steps.toInt();
        }
        filteredSpots.add(FlSpot(i.toDouble(), step.steps.toDouble()));
      }
    }
    filteredSpots.sort((a, b) => a.x.compareTo(b.x));

    debugPrint(filteredSpots.toString());
    setState(() {
      this.allSpots = filteredSpots;
      this.tools = [0];
    });
  }

  int waterIntake = 0;
  // int targetWaterIntake = 2000; // Customize this value as needed

  void incrementWaterIntake() {
    setState(() {
      waterIntake += 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    var media = MediaQuery.of(context).size;
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: tools,
        spots: allSpots,
        isCurved: true,
        barWidth: 2.5,
        // shadow: const Shadow(
        //   blurRadius: 8,
        // ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              TColour.primaryColor1.withOpacity(0.9),
              TColour.primaryColor2.withOpacity(0.1),
              // TColour.primaryColor2.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            TColour.primaryColor1,
            TColour.primaryColor2,
            TColour.primaryColor2,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    // var media=MediaQuery.of(context).size,
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(color: TColour.black1, fontSize: 16),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: TColour.black1,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileView()));
                        },
                        icon: ClipOval(
                          child: Image.asset(
                            widget.gender == "female"
                                ? "assets/images/profile-female.jpg"
                                : "assets/images/profile-male.png",
                            height: media.width * 0.15,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: media.width * .03,
                ),
                Container(
                  height: media.width * .5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: TColour.gradient),
                      borderRadius: BorderRadius.circular(media.width * .075)),
                  child: Stack(alignment: Alignment.center, children: [
                    Opacity(
                      opacity:
                          0.5, // Set the opacity value between 0.0 (fully transparent) to 1.0 (fully opaque).
                      child: Image.asset("assets/images/buble.png",
                          height: media.width * .4,
                          width: double.maxFinite,
                          fit: BoxFit
                              .fitHeight), // The widget that you want to make transparent.
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your BMI Value",
                                style: TextStyle(
                                    color: TColour.black1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${widget.bmiScore}",
                                style: TextStyle(
                                    color: TColour.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: media.width * .03,
                              ),
                              SizedBox(
                                  height: 30,
                                  width: 120,
                                  child: RoundedButton(
                                      title: "update",
                                      type: RoundButtonType.bgGradient,
                                      fontSize: 13,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditProfileView(
                                                  height: widget.height,
                                                  weight: widget.weight,
                                                  sleep: widget.sleep,
                                                  water:
                                                      (widget.targetWaterIntake /
                                                              1000)
                                                          .toDouble(),
                                                  workout: widget.workout,
                                                  age: widget.age,
                                                  gender: widget.gender),
                                            ));
                                      }))
                            ],
                          ),
                          Container(
                            width: media.width * 0.45,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: TColour.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrettyGauge(
                                  gaugeSize: 100,
                                  minValue: 0,
                                  maxValue: 40,
                                  segments: [
                                    GaugeSegment(
                                        'UnderWeight', 18.5, Colors.blueAccent),
                                    GaugeSegment(
                                        'Normal', 6.4, Colors.lightGreen),
                                    GaugeSegment(
                                        'OverWeight', 5, Colors.orange),
                                    GaugeSegment('Obesity', 10.1, Colors.red),
                                  ],
                                  valueWidget: Text(
                                    widget.bmiScore.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  currentValue: widget.bmiScore.toDouble(),
                                  needleColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text(
                                  bmiStatus!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: bmiStatusColor!,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  bmiInterpretation!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: media.width * .05,
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: media.width * .4,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: TColour.primaryColor1.withOpacity(.3),
                          borderRadius: BorderRadius.circular(25)),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Steps Count",
                                  style: TextStyle(
                                      color: TColour.black1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return LinearGradient(
                                            colors: TColour.primary,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)
                                        .createShader(Rect.fromLTRB(
                                            0, 0, bounds.width, bounds.height));
                                  },
                                  child: Text(
                                    "${allSpots.isEmpty ? 0 : allSpots.last.y.toInt()}/4000",
                                    style: TextStyle(
                                        color: TColour.white.withOpacity(.7),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.width * .08,
                          ),
                          Padding(
                            // padding: const EdgeInsets.only(top: 40.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            child: LineChart(
                              LineChartData(
                                showingTooltipIndicators: tools.map((index) {
                                  return ShowingTooltipIndicators([
                                    LineBarSpot(
                                      tooltipsOnBar,
                                      lineBarsData.indexOf(tooltipsOnBar),
                                      tooltipsOnBar.spots[index],
                                    ),
                                  ]);
                                }).toList(),
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  handleBuiltInTouches: false,
                                  touchCallback: (FlTouchEvent event,
                                      LineTouchResponse? response) {
                                    if (response == null ||
                                        response.lineBarSpots == null) {
                                      return;
                                    }
                                    if (event is FlTapUpEvent) {
                                      final spotIndex = response
                                          .lineBarSpots!.first.spotIndex;
                                      tools.clear();
                                      setState(() {
                                        tools.add(spotIndex);
                                      });
                                    }
                                  },
                                  mouseCursorResolver: (FlTouchEvent event,
                                      LineTouchResponse? response) {
                                    if (response == null ||
                                        response.lineBarSpots == null) {
                                      return SystemMouseCursors.basic;
                                    }
                                    return SystemMouseCursors.click;
                                  },
                                  getTouchedSpotIndicator:
                                      (LineChartBarData barData,
                                          List<int> spotIndexes) {
                                    return spotIndexes.map((index) {
                                      return TouchedSpotIndicatorData(
                                        const FlLine(
                                          color: Colors.transparent,
                                        ),
                                        FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, barData, index) =>
                                                  FlDotCirclePainter(
                                            radius: 5,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            strokeWidth: 2,
                                            strokeColor: Colors.green,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipColor: (touchedSpot) =>
                                        Color.fromARGB(255, 217, 78, 222),
                                    tooltipRoundedRadius: 8,
                                    getTooltipItems:
                                        (List<LineBarSpot> lineBarsSpot) {
                                      return lineBarsSpot
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final lineBarSpot = entry.value;

                                        final alignment =
                                            index < lineBarsSpot.length / 2
                                                ? FLHorizontalAlignment.right
                                                : FLHorizontalAlignment.left;
                                        return LineTooltipItem(
                                          "${lineBarSpot.x.toString()}day\n ${lineBarSpot.y.toInt()}steps",
                                          // lineBarSpot.y.toString(),
                                          const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                                lineBarsData: lineBarsData,
                                minY: 0,
                                titlesData: FlTitlesData(
                                  show: false,
                                ),
                                gridData: const FlGridData(show: false),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: media.width * .05,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: TColour.gradient),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today Achieved",
                          style: TextStyle(
                              color: TColour.black1,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                            height: 35,
                            width: media.width * 0.35,
                            child: RoundedButton(
                                title: "workout",
                                type: RoundButtonType.bgGradient,
                                fontSize: 14,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddActivity(),
                                    ),
                                  );
                                }))
                      ]),
                ),
                SizedBox(
                  height: media.width * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 3)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Water Intake",
                              style: TextStyle(
                                  color: TColour.black1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: media.width * 0.02,
                            ),
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                        colors: TColour.primary,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)
                                    .createShader(Rect.fromLTRB(
                                        0, 0, bounds.width, bounds.height));
                              },
                              child: Text(
                                "${waterIntake}/${widget.targetWaterIntake}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: TColour.white.withOpacity(.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.02,
                            ),
                            SimpleAnimationProgressBar(
                              height: media.width * .8,
                              width: 30,
                              backgroundColor: TColour.secondaryColor2,
                              foregrondColor: Colors.purple,
                              ratio: waterIntake /
                                  widget
                                      .targetWaterIntake, // to be chage with the consumed water amount
                              direction: Axis.vertical,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(seconds: 4),
                              borderRadius: BorderRadius.circular(10),
                              gradientColor: LinearGradient(colors: [
                                TColour.primaryColor1,
                                TColour.primaryColor2
                              ]),
                            ),
                            SizedBox(
                              height: media.width * 0.02,
                            ),
                            SizedBox(
                                height: 35,
                                width: double.maxFinite,
                                child: RoundedButton(
                                    title: 'Add🥤',
                                    type: RoundButtonType.bgGradient,
                                    fontSize: 13,
                                    onPressed: incrementWaterIntake))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * .05,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 2)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Calories",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: TColour.black1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                          colors: TColour.primary,
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight)
                                      .createShader(Rect.fromLTRB(
                                          0, 0, bounds.width, bounds.height));
                                },
                                child: Text(
                                  "234 kCal",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: TColour.white.withOpacity(.7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 7.0,
                                percent: 234 / 500,
                                animation: true,
                                animationDuration: 1200,
                                center: new Text(
                                  "46.8%",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: TColour.secondaryColor2,
                                progressColor: TColour.primaryColor1,
                              ),
                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              SizedBox(
                                  height: 35,
                                  width: double.maxFinite,
                                  child: RoundedButton(
                                    title: 'Calories Tracker',
                                    type: RoundButtonType.bgGradient,
                                    fontSize: 12,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SleepTrackerView(),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: media.height * 0.01,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 2)
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Track your Sleep",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColour.black1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: media.height * 0.01,
                                ),
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return LinearGradient(
                                            colors: TColour.primary,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)
                                        .createShader(Rect.fromLTRB(
                                            0, 0, bounds.width, bounds.height));
                                  },
                                  child: Text(
                                    "5hr 30min",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: TColour.white.withOpacity(.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.02,
                                ),
                                CircularPercentIndicator(
                                  radius: 40.0,
                                  lineWidth: 7.0,
                                  percent: 0.30,
                                  animation: true,
                                  animationDuration: 1200,
                                  center: new Text(
                                    "40%",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor: TColour.secondaryColor2,
                                  progressColor: TColour.primaryColor1,
                                ),
                                SizedBox(
                                  height: media.height * 0.02,
                                ),
                                SizedBox(
                                    height: 35,
                                    width: double.maxFinite,
                                    child: RoundedButton(
                                      title: 'Sleep Tracker',
                                      type: RoundButtonType.bgGradient,
                                      fontSize: 13,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SleepTrackerView(),
                                          ),
                                        );
                                      },
                                    ))
                              ]),
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * .05,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
