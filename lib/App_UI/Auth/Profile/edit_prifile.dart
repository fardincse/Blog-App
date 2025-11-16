import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:blog_app/Common_Widget/ele_button.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:provider/provider.dart';

class EditPrifile extends StatefulWidget {
  const EditPrifile({super.key});

  @override
  State<EditPrifile> createState() => _EditPrifileState();
}

class _EditPrifileState extends State<EditPrifile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().userProfileData?.data?.user;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _mobileController.text = user.phone ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPhoto = context.read<UserProvider>().userProfile;
    final user = context.watch<UserProvider>().userProfileData!.data!.user;
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
                  backgroundImage: AssetImage(userPhoto),
                  backgroundColor: Colors.grey,
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
              Center(
                child: Text(
                  user.email!,
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF9EA6BA)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Display Name',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    TextInputFiled(
                      controller: _nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        LengthLimitingTextInputFormatter(30),
                      ],
                      hintText: 'Name',
                      keyBoardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else if (value.length < 4) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mobile',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    TextInputFiled(
                      controller: _mobileController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(11),
                      ],
                      hintText: 'Mobile number',
                      keyBoardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (value.length != 11) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
        child: Button(
                      buttonName: 'Save Change',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final res = await context
                              .read<UserProvider>()
                              .editUserProfile(
                                _nameController.text,
                                _mobileController.text,
                              );
                          if (res == true) {
                            showSnackBarMessage(context, 'Save Update');
                            Navigator.pop(context);
                          }else{
                            showSnackBarMessage(context, 'Failed to update profile');
                          }
                        } else {
                          null;
                        }
                      },
                    ),
        ),
    );
  }
}
