import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:blog_app/Helpre_Classh/api/Login/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/ele_button.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../Signup/signup.dart';
import '../../Home/home.dart';
import 'package:blog_app/Model/Login_Model/post_login_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final box = GetStorage();

  bool _obscureText = true;
  bool isLoading = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign in',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextInputFiled(
                          controller: _emailController,
                          hintText: 'E-mail',
                          keyBoardType: TextInputType.emailAddress,
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
                        SizedBox(height: 20),
                        TextInputFiled(
                          controller: _passwordController,
                          keyBoardType: TextInputType.text,
                          hintText: 'Password',
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
                              return 'Please Enter your Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50),
                        Button(
                          buttonName: 'Sign in',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final result = await userLogin(
                                PostLoginModel(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                              if (result.success) {
                                box.write('token', result.data.token);
                                context.read<UserProvider>().addUserData(result);
                                showSnackBarMessage(context, result.message);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              } else {
                                showDialog(
                                  context: context, 
                                  builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r)
                                      ),
                                      title: Text('Invalid email or password', style: TextStyle(fontSize: 16.sp, color: Colors.black),),
                                      actions: [
                                        Button(buttonName: 'Ok', onPressed: (){Navigator.pop(context);})
                                      ],
                                    );
                                  }
                                  );
                                _emailController.clear();
                                _passwordController.clear();
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF9EA6BA),
                          ),
                        ),
                        CustomTextButton(
                          buttonName: 'Sign up',
                          color: Color.fromARGB(255, 68, 113, 229),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                        ),
                      ],
                    ),
      ),
    );
  }
}
