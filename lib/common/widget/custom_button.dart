import 'package:flutter/material.dart';

import '../../utils/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color color;
  final Color textcolor;
  final double elevation;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 0,
    this.height = 0,
    this.color = AppColors.mainColorbutton,
    this.textcolor = Colors.white,
    this.elevation = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: color,
          minimumSize: ((width == 0 && height == 0)
              ? const Size(double.infinity, 50)
              : Size(width, height)),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textcolor, fontSize: 16, fontWeight: FontWeight.w400),
        ));
  }
}
