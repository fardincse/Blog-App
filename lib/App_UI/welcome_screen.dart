import 'package:blog_app/App_UI/Auth/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/ele_button.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeScreen extends StatelessWidget{

  final box = GetStorage();

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: 390.w,
            height: 320.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/Frame.png',), fit: BoxFit.cover)
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Welcome to Your Personal Blog Space',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          'Discover articles, save your favorites, and engage with the community.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ),
              ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
        child: Button(
                      buttonName: 'Get Started', 
                      onPressed: (){
                        box.write('isNotFirstTime', true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      }
                      ),
      )
    );
  }
}