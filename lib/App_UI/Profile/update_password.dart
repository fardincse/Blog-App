import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _conpassController = TextEditingController();

  bool _obText = true;
  bool _nobText = true;
  bool _cobText = true;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Current Password',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    TextInputFiled(
                      controller: _passwordController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Enter your current password',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._%-]'),
                        ),
                        LengthLimitingTextInputFormatter(32),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obText = !_obText;
                          });
                        },
                        icon: Icon(
                          _obText ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      obText: _obText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Emter your current Password';
                        }
                        // if (value.length < 8) {
                        //   return 'Password must be at least 8 characters';
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'New Password',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    TextInputFiled(
                      controller: _newpassController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Enter your new password',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._%-]'),
                        ),
                        LengthLimitingTextInputFormatter(32),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _nobText = !_nobText;
                          });
                        },
                        icon: Icon(
                          _nobText ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      obText: _nobText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter a Password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Confirm password',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    TextInputFiled(
                      controller: _conpassController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Confirm New Password',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._%-]'),
                        ),
                        LengthLimitingTextInputFormatter(32),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _cobText = !_cobText;
                          });
                        },
                        icon: Icon(
                          _cobText ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      obText: _cobText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please comflim your password';
                        } else if (value != _newpassController.text) {
                          return 'Password didn\'t match,';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Button(
                buttonName: 'Update Password',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showSnackBarMessage(
                      context,
                      'Sucessfully change your password',
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
