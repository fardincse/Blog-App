import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/button.dart';
import 'package:blog_app/Common_Widget/text_button.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import '../Signup/signup.dart';
import '../Home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  controller: _userNameController,
                  hintText: 'Email or username',
                  keyBoardType: TextInputType.emailAddress,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.grey[800],
                    ),
                  ),
                  obText: _obscureText,
                ),

                SizedBox(height: 50),
                Button(
                  buttonName: 'Sign in',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
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
          ],
        ),
      ),
    );
  }
}
