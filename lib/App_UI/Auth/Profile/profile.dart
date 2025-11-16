import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:blog_app/Helpre_Classh/api/Logout/log_out_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/ele_button.dart';
import 'package:blog_app/App_UI/Auth/Login/login.dart';
import 'package:provider/provider.dart';
import 'edit_prifile.dart';
import 'update_password.dart';
import 'see_profile_photo.dart';
import 'package:get_storage/get_storage.dart';

class Profile extends StatelessWidget {

  final box = GetStorage();
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().userProfileData!.data!.user;
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SeeProfilePhoto()));
                      },
                      child: CircleAvatar(
                        radius: 64.r,
                        backgroundImage: AssetImage(context.read<UserProvider>().userProfile),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      user!.name!,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    user.email!,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
        child: Button(
                buttonName: 'Log out',
                onPressed: () async{
                  showSnackBarMessage(context, 'Processing, Please wait');
                  final logout = await logOut();
                  if(logout.success == true){
                    box.remove('token');
                    showSnackBarMessage(context, logout.message);
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                  }
                  else{
                    showSnackBarMessage(context, 'Filed to log out');
                  }
                },
              ),
        ),
    );
  }
}
