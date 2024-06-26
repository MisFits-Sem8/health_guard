import 'package:flutter/material.dart';
import '../common/color_extension.dart';
import '../view/profile/complete_profile.dart';

class GenderCard extends StatelessWidget {
  const GenderCard(
      {super.key,
      required this.onPress,
      required this.genderType,
      required this.boxColor});
  final Gender genderType;
  final Color boxColor;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                genderType == Gender.male
                    ? Icons.male_rounded
                    : Icons.female_rounded,
                size: 70,
              ),
              Text(
                genderType == Gender.male ? "Male" : "Female",
                style: TextStyle(color: TColour.gray, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
