import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _obscureText = true;
  bool _cobsecureText = true;

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
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.w),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    TextInputFiled(
                      controller: _userController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Enter your username',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]')),
                        LengthLimitingTextInputFormatter(15),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter a UserName';
                        } else if (value.length < 6) {
                          return 'Username must be at last 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'E-mail',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    TextInputFiled(
                      controller: _emailController,
                      keyBoardType: TextInputType.emailAddress,
                      hintText: 'Enter your E-mail',
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your E-mail address';
                        }
                        String pattern =
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                        RegExp regex = RegExp(pattern);

                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    TextInputFiled(
                      controller: _passwordController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Enter a strong password',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._%-]'),
                        ),
                        LengthLimitingTextInputFormatter(32),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      obText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Emter a Password';
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
                    TextInputFiled(
                      controller: _rePasswordController,
                      keyBoardType: TextInputType.text,
                      hintText: 'Confirm your password',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._%-]'),
                        ),
                        LengthLimitingTextInputFormatter(32),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _cobsecureText = !_cobsecureText;
                          });
                        },
                        icon: Icon(
                          _cobsecureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      obText: _cobsecureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please comflim your password';
                        }else if(value != _passwordController.text){
                          return 'Password didn\'t match,';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Button(
                      buttonName: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showSnackBarMessage(context, 'Register Sucessfull, Please Login');
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Alredy have an account?',
                style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
              ),
              CustomTextButton(
                buttonName: 'Login',
                color: Color.fromARGB(255, 68, 113, 229),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
