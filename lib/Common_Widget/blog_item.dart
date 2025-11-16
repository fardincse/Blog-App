import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogItem extends StatelessWidget {
  final String cetagory;
  final String title;
  final String decoration;
  final String? imagePath;
  final VoidCallback onTap;

  const BlogItem({
    super.key,
    required this.cetagory,
    required this.title,
    required this.decoration,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
        //  height: 150.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 218.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cetagory,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
                    ),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      decoration,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130.h,
                width: 130.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imagePath!, fit: BoxFit.cover,
                  // errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/no-image-found.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
