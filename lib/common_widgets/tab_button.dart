import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class TabButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final bool isActive;
  final double size;

  const TabButton(
      {super.key,
      required this.iconData,
      required this.onTap,
      required this.isActive,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => RadialGradient(
              center: Alignment.topCenter,
              radius: 0.5,
              colors: isActive
                  ? TColour.primary
                  : TColour.secondary, // Gradient colors for the icon
            ).createShader(bounds),
            child: Icon(
              iconData,
              size: size,
            ),
          ),
          if (isActive)
            SizedBox(
              height: size * 0.1,
            ),
          if (isActive)
            Container(
              height: size * 0.13,
              width: size * 0.13,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: TColour.primary),
                borderRadius: BorderRadius.circular(2),
              ),
            )
        ],
      ),
    );
  }
}
