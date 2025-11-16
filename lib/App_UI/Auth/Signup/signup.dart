import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:blog_app/Common_Widget/ele_button.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/api/Register/register_api.dart';
import 'package:blog_app/Model/Register_Model/register.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _obscureText = true;
  bool _cobsecureText = true;
  bool isLoading = false;

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
          child: Stack(
            children: [
              Column(
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
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextInputFiled(
                          controller: _nameController,
                          keyBoardType: TextInputType.text,
                          hintText: 'Enter your username',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-z0-9]'),
                            ),
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
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextInputFiled(
                          controller: _emailController,
                          keyBoardType: TextInputType.emailAddress,
                          hintText: 'Enter your E-mail',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your E-mail address';
                            }
                            String pattern =
                                r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$';
                            RegExp regex = RegExp(pattern);

                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mobile',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextInputFiled(
                          controller: _mobileController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(11),
                          ],
                          hintText: '01XXX-XXXXXX',
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
                        SizedBox(height: 10),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextInputFiled(
                          controller: _passwordController,
                          keyBoardType: TextInputType.text,
                          hintText: 'Enter a strong password',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@$#&._%-]'),
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
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextInputFiled(
                          controller: _rePasswordController,
                          keyBoardType: TextInputType.text,
                          hintText: 'Confirm your password',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@$#&._%-]'),
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
                            } else if (value != _passwordController.text) {
                              return 'Password didn\'t match,';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Button(
                          buttonName: 'Register',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final result = await postRegister(
                                RegisterModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _mobileController.text,
                                  password: _passwordController.text,
                                ),
                              );
                              if (result.success) {
                                showSnackBarMessage(
                                  context,
                                  'Register Sucessfull, Please Login',
                                );
                                Navigator.pop(context);
                              } else {
                                showSnackBarMessage(
                                  context,
                                  result.error!.first.message!,
                                );
                                _nameController.clear();
                                _emailController.clear();
                                _mobileController.clear();
                                _passwordController.clear();
                                _rePasswordController.clear();
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white70,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    );
  }
}
