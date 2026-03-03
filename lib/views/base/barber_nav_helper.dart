import 'package:get/get.dart';

import '../screens/home/barber/barber_home_screen.dart';
import '../screens/home/barber/profile/barber_profile_screen.dart';
import '../screens/home/barber/request/barber_request_screen.dart';
import '../screens/home/barber/schedule/barber_schedule_screen.dart';


class BarberNavHelper {
  static void onTap(int index, int currentIndex) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.offAll(
              () => const BarberHomeScreen(),
          transition: Transition.leftToRight,
        );
        break;
      case 1:
        Get.offAll(
              () => const BarberScheduleScreen(),
          transition: index > currentIndex
              ? Transition.rightToLeft
              : Transition.leftToRight,
        );
        break;
      case 2:
        Get.offAll(
              () => const BarberRequestScreen(),
          transition: index > currentIndex
              ? Transition.rightToLeft
              : Transition.leftToRight,
        );
        break;
      case 3:
        Get.offAll(
              () => const BarberProfileScreen(),
          transition: Transition.rightToLeft,
        );
        break;
    }
  }
}