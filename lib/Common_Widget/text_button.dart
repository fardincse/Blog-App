import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget{

  final String buttonName;
  final VoidCallback onPressed;
  final Color color;
  const CustomTextButton({super.key, required this.buttonName, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 16.sp,
          color: color
        ),
      )
      );
  }

}