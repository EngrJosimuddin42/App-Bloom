import 'package:get/get.dart';
import '../helpers/storage_helper.dart';
import '../views/screens/home/barber/barber_home_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/onboarding_screen.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    // ── Navigation Logic ──
    if (StorageHelper.isLoggedIn() && StorageHelper.getToken() != null) {
      Get.offAll(
            () => const BarberHomeScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 500),
      );
    } else if (StorageHelper.isOnboardingDone()) {
      Get.offAll(
            () => const LoginScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      Get.offAll(
            () => const OnboardingScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}