import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'barber_home_controller.dart';
import '../../views/screens/home/barber/profile_setup/application_id_card.dart';

class BarberRequiredInfoController extends GetxController {
  // ── Form Controllers ──
  final nameController     = TextEditingController(text: 'Josimuddin (Dev)');
  final emailController    = TextEditingController(text: 'josimcse@gmail.com');
  final phoneController    = TextEditingController(text: '+8801738664382');
  final idController       = TextEditingController(text: '1234567890');
  final locationController = TextEditingController(text: 'Mohakhali, Dhaka, Bangladesh');

  // ── Loading ──
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // ── Experience Counter ──
  final _experience = 1.obs;
  int get experience => _experience.value;

  void increaseExperience() => _experience.value++;
  void decreaseExperience() {
    if (_experience.value > 0) _experience.value--;
  }

  // ── File Uploads ──
  final workPhotos   = <String>[].obs;
  final certificates = <String>[].obs;

  void pickWorkPhotos() {}
  void pickCertificates() {}

  // ── Submit ──
  Future<void> submitApplication() async {
    if (!_validate()) return;

    _isLoading.value = true;

    try {
      // ── DEV MODE: mock response ──
      await Future.delayed(const Duration(milliseconds: 500));
      const applicationId = 'TH-2025-847';

      // ── BarberHomeController
      final homeController = Get.isRegistered<BarberHomeController>()
          ? Get.find<BarberHomeController>()
          : Get.put(BarberHomeController());

      homeController.setApplicationId(applicationId);

      // ── ApplicationIdCard screen এ offline
      await homeController.toggleOnlineStatus(false);

      Get.to(
            () => const ApplicationIdCard(),
        transition: Transition.rightToLeft,
      );

      // ── PRODUCTION: uncomment ──
      // final api = Get.find<ApiService>();
      // final result = await api.submitBarberApplication(
      //   name: nameController.text,
      //   email: emailController.text,
      //   phone: phoneController.text,
      //   idNumber: idController.text,
      //   location: locationController.text,
      //   experience: experience,
      // );
      // final applicationId = result['application_id'];
      // Get.find<BarberHomeController>().setApplicationId(applicationId);
      // Get.to(() => const ApplicationIdCard(), transition: Transition.rightToLeft);

    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: const Color(0xFFEF4444),
          colorText: const Color(0xFFFFFFFF));
    } finally {
      _isLoading.value = false;
    }
  }

  bool _validate() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Name is required');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Phone is required');
      return false;
    }
    if (idController.text.trim().isEmpty) {
      Get.snackbar('Error', 'ID Number is required');
      return false;
    }
    if (locationController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Location is required');
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idController.dispose();
    locationController.dispose();
    super.onClose();
  }
}