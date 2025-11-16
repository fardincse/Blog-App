import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputFiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final bool? obText;
  final FormFieldValidator? validator;
  final int? maxLine;
  const TextInputFiled({
    super.key,
    required this.controller,
    required this.inputFormatters,
    required this.hintText,
    required this.keyBoardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obText,
    this.validator, 
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.grey[700],
      keyboardType: keyBoardType,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: obText ?? false,
      obscuringCharacter: '•',
      maxLines: maxLine ?? 1,
      minLines: 1,
      style: TextStyle(fontSize: 16.sp, color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0xFF292E38),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Color(0xFF9EA6BA)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
