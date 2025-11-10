import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'Login/login.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

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
                  Button(
                    buttonName: 'Get Started', 
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    }
                    )
                ],
              ),
              ),
          )
        ],
      ),
    );
  }
}