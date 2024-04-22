import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/common_widgets/rounded_btn.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final double bmiScore = 10;

  final int age = 24;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;
  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = const Color.fromARGB(255, 30, 233, 233);
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Color.fromARGB(255, 53, 21, 235);
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = const Color.fromARGB(255, 244, 54, 216);
    }
  }

  List<int> tools = [14];
  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 2),
        FlSpot(4, 2),
        FlSpot(5, 3),
        FlSpot(6, 4),
        FlSpot(7, 2),
        FlSpot(8, 1),
        FlSpot(9, 2),
        FlSpot(10, 1.5),
        FlSpot(11, 2),
        FlSpot(12, 2),
        FlSpot(13, 3),
        FlSpot(14, 4),
        FlSpot(15, 2),
      ];

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
    return Scaffold(
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
                        "Welcome Back !",
                        style: TextStyle(color: TColour.black1, fontSize: 16),
                      ),
                      Text(
                        "Harshani Bandara",
                        style: TextStyle(
                            color: TColour.black1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/images/user.jpeg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.fitHeight,
                      )),
                ],
              ),
              SizedBox(
                height: media.width * .05,
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
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your BMI",
                              style:
                                  TextStyle(color: TColour.white, fontSize: 16),
                            ),
                            Text(
                              "Value :${bmiScore}",
                              style: TextStyle(
                                  color: TColour.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: media.width * .03,
                            ),
                            SizedBox(
                                height: 30,
                                width: 120,
                                child: RoundedButton(
                                    title: "Update",
                                    type: RoundButtonType.bgGradient,
                                    fontSize: 12,
                                    onPressed: () {}))
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            color: Colors.white,
                            elevation: 12,
                            // shape: const RoundedRectangleBorder(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Your Score",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                PrettyGauge(
                                  gaugeSize: 100,
                                  minValue: 0,
                                  maxValue: 40,
                                  segments: [
                                    GaugeSegment('UnderWeight', 18.5,
                                        Color.fromARGB(255, 30, 233, 233)),
                                    GaugeSegment('Normal', 6.4, Colors.green),
                                    GaugeSegment('OverWeight', 5,
                                        Color.fromARGB(255, 53, 21, 235)),
                                    GaugeSegment('Obese', 10.1,
                                        Color.fromARGB(255, 244, 54, 216)),
                                  ],
                                  valueWidget: Text(
                                    bmiScore.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  currentValue: bmiScore.toDouble(),
                                  needleColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bmiStatus!,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: bmiStatusColor!,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bmiInterpretation!,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
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
              Container(
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
                              "1520/4000",
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
                      padding: const EdgeInsets.only(top: 40.0),
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
                                final spotIndex =
                                    response.lineBarSpots!.first.spotIndex;
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
                            getTouchedSpotIndicator: (LineChartBarData barData,
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
                                return lineBarsSpot.map((lineBarSpot) {
                                  return LineTooltipItem(
                                    "${lineBarSpot.x.toString()}day\n ${lineBarSpot.x.toInt()}steps",
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
                        "Today Target",
                        style: TextStyle(
                            color: TColour.black1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          height: 35,
                          width: 70,
                          child: RoundedButton(
                              title: "check",
                              type: RoundButtonType.bgGradient,
                              fontSize: 12,
                              onPressed: () {}))
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
