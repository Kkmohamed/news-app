import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';

class OnboardingController with ChangeNotifier {
  PageController pageController = PageController();

  int currentIndex = 0;
  bool isLastPage = false;
  void onPgaeChanged(int index) {
    currentIndex = index;
    if (index == OnboardingModel.onboardingList.length - 1) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }
}
