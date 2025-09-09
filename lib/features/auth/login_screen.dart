import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/app_logo.png', height: 45),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Newts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                obscureText: false,
                controller: emailController,
                hintText: 'usama@gmail.com',
                title: 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                obscureText: !isVisible,
                controller: passwordController,
                hintText: '*************',
                title: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon:
                      isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
