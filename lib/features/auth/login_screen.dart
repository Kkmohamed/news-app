import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/localdata/preferences_manager.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isVisible = false;
  String? errorMessage;

  bool isLoading = false;

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString('user_email');
    final savedPassword = PreferencesManager().getString('user_password');
    if (savedEmail == null || savedPassword == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'No registered user found. Please sign up first.';
      });
      return;
    }
    if (savedEmail != emailController.text.trim() ||
        savedPassword != passwordController.text.trim()) {
      setState(() {
        isLoading = false;
        errorMessage = 'Invalid email or password. Please try again.';
      });
      return;
    } else {
      await PreferencesManager().setBool('is_logged_in', true);
      setState(() {
        isLoading = false;
        errorMessage = null;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      height: AppSizes.h45,
                    ),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  Text(
                    'Welcome to Newts',
                    style: TextStyle(
                      fontSize: AppSizes.sp20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    controller: emailController,
                    hintText: 'usama@gmail.com',
                    title: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      final RegExp emailRegExpSimple = RegExp(
                        r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
                      );
                      if (!emailRegExpSimple.hasMatch(value)) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.ph24),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      // final RegExp passwordRegExp = RegExp(
                      //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,20}$',
                      // );
                      // if (!passwordRegExp.hasMatch(value)) {
                      //   return 'Please Enter Valid Password';
                      // }
                      return null;
                    },
                    obscureText: !isVisible,
                    controller: passwordController,
                    hintText: '*************',
                    title: 'Password',
                  ),
                  SizedBox(height: AppSizes.ph24),
                  if (errorMessage != null)
                    Text(
                      errorMessage ?? '',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.h48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          login();
                        }
                      },
                      child:
                          isLoading
                              ? CircularProgressIndicator()
                              : Text('Sign In'),
                    ),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: AppSizes.sp16),
                      ),
                      SizedBox(width: AppSizes.pw8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: AppSizes.sp16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
