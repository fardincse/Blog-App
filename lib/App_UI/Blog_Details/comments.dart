import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Comments extends StatelessWidget{

  final String imagePath;
  final String name;
  final String ago;
  final String comment;

  const Comments({super.key, required this.imagePath, required this.name, required this.ago, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(imagePath),
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 5,),
          SizedBox(
            width: 305.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      ago,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF9EA6BA)
                      ),
                    )
                  ],
                ),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}