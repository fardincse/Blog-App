import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogAppbar extends StatelessWidget {
  const BlogAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Blog',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
