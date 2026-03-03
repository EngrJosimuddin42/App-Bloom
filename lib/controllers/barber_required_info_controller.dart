import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/screens/home/barber/profile_setup/application_id_card.dart';
import '../views/screens/home/barber/profile_setup/verification_complete_dialog.dart';


// TODO: uncomment for production
// import '../services/api_service.dart';

// ════════════════════════════════════════════════════════════
//  ⚠️  DEVELOPMENT MODE — mock data active
//  Before production:
//   • uncomment ApiService calls
//   • remove mock delays & hardcoded applicationId
// ════════════════════════════════════════════════════════════

class BarberRequiredInfoController extends GetxController {
  // ── Form Controllers ──
  final nameController     = TextEditingController();
  final emailController    = TextEditingController();
  final phoneController    = TextEditingController();
  final idController       = TextEditingController();
  final locationController = TextEditingController();

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

  // TODO [DEV]: image_picker integrate korte hobe
  void pickWorkPhotos() {}

  // TODO [DEV]: file_picker integrate korte hobe
  void pickCertificates() {}

  // ── Submit ──
  Future<void> submitApplication() async {
    if (!_validate()) return;

    _isLoading.value = true;

    try {
      // ── DEV MODE: mock response ──
      // TODO [DEV]: niche er block ta remove kore PRODUCTION block uncomment korte hobe
      await Future.delayed(const Duration(milliseconds: 500));
      const applicationId = 'TH-2025-847';

      Get.to(
            () => ApplicationIdCard(
          applicationId: applicationId,
          onVerify: () {
            VerificationCompleteDialog.show(
              onOk: () => Get.back(),
            );
          },
        ),
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
      // Get.to(() => ApplicationIdCard(
      //   applicationId: applicationId,
      //   onVerify: () => VerificationCompleteDialog.show(onOk: () => Get.back()),
      // ));

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