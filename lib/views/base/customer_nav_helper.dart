import 'package:get/get.dart';
import '../screens/home/customer/customer_home_screen.dart';
import '../screens/home/customer/my_booking_screen.dart';

class CustomerNavHelper {
  static void onTap(int index, int currentIndex) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.offAll(
              () => const CustomerHomeScreen(),
          transition: Transition.leftToRight,
        );
        break;
      case 1:
        Get.offAll(
              () => const MyBookingScreen(),
          transition: index > currentIndex
              ? Transition.rightToLeft
              : Transition.leftToRight,
        );
        break;
      case 2:
      // Get.offAll(() => const CustomerProfileScreen(),
      //   transition: Transition.rightToLeft,
      // );
        break;
    }
  }
}