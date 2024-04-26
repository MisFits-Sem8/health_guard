import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class GoalCard extends StatelessWidget {
  final String goalname;
  final String target;
  final String unit;
  final String imageName;
  const GoalCard(
      {super.key,
      required this.goalname,
      required this.target,
      required this.imageName,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: TColour.lightGray.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/images/$imageName.png",
              width: 80,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              goalname,
              style: TextStyle(
                  color: TColour.black1.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: TColour.primary,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  target,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 14,
                  color: TColour.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
