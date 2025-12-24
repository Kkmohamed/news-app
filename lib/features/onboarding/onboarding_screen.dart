import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/localdata/preferences_manager.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  _onFinish(BuildContext context) async {
    await PreferencesManager().setBool('onboarding_complete', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      builder: (context, child) {
        final OnboardingController controller =
            context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFF6F7F9),
            actions: [
              Consumer<OnboardingController>(
                builder: (context, OnboardingController value, child) {
                  return !value.isLastPage
                      ? TextButton(
                        onPressed: () {
                          _onFinish(context);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(fontSize: AppSizes.sp16),
                        ),
                      )
                      : SizedBox();
                },
              ),
            ],
          ),
          body: PageView.builder(
            onPageChanged: (value) {
              context.read<OnboardingController>().onPgaeChanged(value);
            },
            controller: controller.pageController,
            itemCount: OnboardingModel.onboardingList.length,
            itemBuilder: (BuildContext context, int index) {
              final OnboardingModel model =
                  OnboardingModel.onboardingList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.ph30,
                  horizontal: AppSizes.pw16,
                ),
                child: Column(
                  children: [
                    Image.asset(model.image),
                    SizedBox(height: AppSizes.ph24),
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: AppSizes.sp20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF4E4B66),
                      ),
                    ),
                    SizedBox(height: AppSizes.ph12),
                    Text(
                      model.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF6E7191),
                      ),
                    ),
                    SizedBox(height: AppSizes.ph24),
                    SmoothPageIndicator(
                      controller: controller.pageController, // PageController
                      count: OnboardingModel.onboardingList.length,
                      effect: WormEffect(
                        dotHeight: 14,
                        dotWidth: 14,
                        spacing: 8.0,
                        radius: 8.0,
                        dotColor: Color(0xFFD3D3D3),
                        activeDotColor: LightColor.primary,
                      ), // your preferred effect
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (!controller.isLastPage) {
                          controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 425),
                            curve: Curves.linear,
                          );
                        } else {
                          _onFinish(context);
                        }
                      },
                      child: Consumer<OnboardingController>(
                        builder: (context, OnboardingController value, child) {
                          return value.isLastPage
                              ? const Text('Get Started')
                              : const Text('Next');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
