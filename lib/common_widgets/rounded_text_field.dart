import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final String hintText;
  final IconData iconName;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? rightIcon;

  const RoundTextField(
      {super.key,
      required this.hintText,
      this.controller,
      required this.iconName,
      required this.keyboardType,
      this.obscureText = false,
      this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TColour.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: rightIcon,
            prefixIcon: Icon(iconName),
            hintText: hintText,
            hintStyle: TextStyle(color: TColour.gray, fontSize: 12)),
      ),
    );
  }
}
