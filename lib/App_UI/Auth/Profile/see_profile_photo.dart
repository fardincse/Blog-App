import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SeeProfilePhoto extends StatelessWidget{
  const SeeProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context); 
          },
          icon: Icon(Icons.arrow_back, size: 25.sp, color: Colors.white,)
          ),
          title: Text('Profile Photo', style: TextStyle(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(context.read<UserProvider>().userProfile), fit: BoxFit.contain)
        ),
      ),
    );
  }
}