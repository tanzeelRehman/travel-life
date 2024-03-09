import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:starter_app/src/styles/app_colors.dart';

class FullLoadingIndicator extends StatelessWidget {
  const FullLoadingIndicator({
    Key? key,
    this.size = 30,
    this.strokeWidth = 3,
    this.color = Colors.black,
    this.value,
  }) : super(key: key);

  final double size;
  final double strokeWidth;
  final Color color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation(AppColors.appSkyBlue),
          ),
        ),
      ),
    );
  }
}
