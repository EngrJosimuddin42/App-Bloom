import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/local_storage_service.dart';
import '../../utils/constants/onboarding_data.dart';
import '../views/screens/login_screen.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  bool get isLastPage => currentPage.value == onboardingPages.length - 1;

  void nextPage() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      onGetStarted();
    }
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void skipToEnd() {
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onGetStarted() async {
    await LocalStorageService.setOnboardingCompleted();
    Get.offAll(
          () => const LoginScreen(),
      transition: Transition.fade,
      duration: const Duration(milliseconds: 500),
    );
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}