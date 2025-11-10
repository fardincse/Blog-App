import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'package:blog_app/App_UI/Login/login.dart';
import 'edit_prifile.dart';
import 'update_password.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
          icon: Icon(Icons.arrow_back, size: 25.sp, color: Colors.white),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_outlined,
              size: 25.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
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
                Text(
                  'ethan.carter@email.com\nSoftware Engineer',
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF9EA6BA)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPrifile(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    CustomTextButton(
                      buttonName: 'Edit profile',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPrifile(),
                          ),
                        );
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
                          },
                          icon: Icon(
                            Icons.lock_outline,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    CustomTextButton(
                      buttonName: 'Update password',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Button(
              buttonName: 'Log out',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
