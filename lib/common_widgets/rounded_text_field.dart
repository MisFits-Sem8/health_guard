import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final String hintText;
  final IconData iconName;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? rightIcon;
  final String? Function(String?)? validator; // Add this line

  const RoundTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.iconName,
    required this.keyboardType,
    this.obscureText = false,
    this.rightIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TColour.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
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
