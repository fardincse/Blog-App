import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCommentOptionsDialog(
  BuildContext context,
  int commentId,
  String oldContent,
  VoidCallback onEdit,
  VoidCallback onDelete,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text("Comment Options"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                onEdit();
              },
              icon: Icon(Icons.edit, color: Colors.blueAccent, size: 28.sp),
              tooltip: "Edit",
            ),
            SizedBox(width: 25.w,),
            IconButton(
              onPressed: () {
                Navigator.pop(context); 
                onDelete();
              },
              icon: Icon(Icons.delete, color: Colors.redAccent, size: 28.sp),
              tooltip: "Delete",
            ),
          ],
        ),
      );
    },
  );
}
