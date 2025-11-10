import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';

class EditPrifile extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emilController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  EditPrifile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  radius: 64.r,
                  backgroundImage: AssetImage('assets/images/profile3.png'),
                  backgroundColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Ethan Carter',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'ethan.carter@email.com',
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF9EA6BA)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Display Name',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(height: 5,),
              inputField(
                controller: _nameController,
                maxLine: 1,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp('r[a-zA-Z]')),
                  LengthLimitingTextInputFormatter(30),
                ],
                hintText: 'Name'
              ),
              SizedBox(height: 10),
              Text(
                'Email',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(height: 5,),
              inputField(
                controller: _emilController,
                maxLine: 1,
                inputFormatter: [LengthLimitingTextInputFormatter(40)],
                hintText: 'E-mail'
              ),
              SizedBox(height: 10),
              Text(
                'Bio',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(height: 5,),
              inputField(
                controller: _bioController,
                minLine: 4,
                maxLine: 5,
                inputFormatter: [LengthLimitingTextInputFormatter(100)],
                hintText: 'Enter your bio in 100 words...'
              ),
              SizedBox(height: 50,),
              Button(buttonName: 'Save Change', onPressed: (){
                showSnackBarMessage(context, 'Save Update');
                Navigator.pop(context);
              }),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  TextField inputField({
    required dynamic controller,
    int? minLine,
    required int maxLine,
    required inputFormatter,
    String? hintText
  }) {
    return TextField(
      controller: _nameController,
      maxLines: maxLine,
      minLines: minLine,
      cursorColor: Colors.grey,
      inputFormatters: inputFormatter,
      style: TextStyle(fontSize: 16.sp, color: Color(0xFF9EA6BA)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF292E38),
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
