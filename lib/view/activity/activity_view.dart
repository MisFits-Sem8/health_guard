import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  List<int> tools = [1, 2, 3];
  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 2),
        FlSpot(4, 2),
        FlSpot(5, 3),
        FlSpot(6, 4),
        FlSpot(7, 2),
      ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              TColour.primaryColor1.withOpacity(0.4),
              TColour.primaryColor2.withOpacity(0.1),
              TColour.primaryColor2.withOpacity(0.1),
            ],
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Text(
              "hey there",
              style: TextStyle(color: TColour.black1, fontSize: 16),
            ),
            SizedBox(
              height: media.width * .05,
            ),
            Text(
              "Activity summary",
              style: TextStyle(
                  color: TColour.black1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: media.width * .02,
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
                        vertical: 25, horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Heart Rate",
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
                            "78 BPM",
                            style: TextStyle(
                                color: TColour.white.withOpacity(.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                  LineChart(
                    LineChartData(
                      showingTooltipIndicators:
                          showingTooltipOnSpots.map((index) {
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
                        touchCallback:
                            (FlTouchEvent event, LineTouchResponse? response) {
                          if (response == null ||
                              response.lineBarSpots == null) {
                            return;
                          }
                          if (event is FlTapUpEvent) {
                            final spotIndex =
                                response.lineBarSpots!.first.spotIndex;
                            setState(() {
                              if (showingTooltipOnSpots.contains(spotIndex)) {
                                showingTooltipOnSpots.remove(spotIndex);
                              } else {
                                showingTooltipOnSpots.add(spotIndex);
                              }
                            });
                          }
                        },
                        mouseCursorResolver:
                            (FlTouchEvent event, LineTouchResponse? response) {
                          if (response == null ||
                              response.lineBarSpots == null) {
                            return SystemMouseCursors.basic;
                          }
                          return SystemMouseCursors.click;
                        },
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((index) {
                            return TouchedSpotIndicatorData(
                              const FlLine(
                                color: Colors.pink,
                              ),
                              FlDotData(
                                show: true,
                                getDotPainter:
                                    (spot, percent, barData, index) =>
                                        FlDotCirclePainter(
                                  radius: 8,
                                  color: Colors.red,
                                  strokeWidth: 2,
                                  strokeColor: Colors.green,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Colors.pink,
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                            return lineBarsSpot.map((lineBarSpot) {
                              return LineTooltipItem(
                                lineBarSpot.y.toString(),
                                const TextStyle(
                                  color: Colors.white,
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
                        leftTitles: const AxisTitles(
                          axisNameWidget: Text('count'),
                          axisNameSize: 24,
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 0,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return bottomTitleWidgets(
                                value,
                                meta,
                                constraints.maxWidth,
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          axisNameWidget: Text('count'),
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 0,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          axisNameWidget: Text(
                            'Wall clock',
                            textAlign: TextAlign.left,
                          ),
                          axisNameSize: 24,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 0,
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
