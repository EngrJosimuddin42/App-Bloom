import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/screens/forgot_password/forgot_password_screen.dart';

class LoginController extends GetxController {

  // ── Controllers ──
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ── State ──
  final _obscurePassword = true.obs;
  final _isLoading = false.obs;
  final _emailError = RxnString();
  final _passwordError = RxnString();

  // ── Getters ──
  bool get obscurePassword => _obscurePassword.value;
  bool get isLoading => _isLoading.value;
  String? get emailError => _emailError.value;
  String? get passwordError => _passwordError.value;

  bool get isFormFilled =>
      emailController.text.trim().isNotEmpty &&
          passwordController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(update);
    passwordController.addListener(update);
  }

  // ── Toggle Password Visibility ──
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
    update();
  }

  // ── Validation ──
  bool _validate() {
    bool isValid = true;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      _emailError.value = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      _emailError.value = null;
    }

    if (password.isEmpty) {
      _passwordError.value = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      _passwordError.value = 'Minimum 6 characters';
      isValid = false;
    } else {
      _passwordError.value = null;
    }

    update();
    return isValid;
  }

  // ── Sign In ──
  Future<void> signIn(BuildContext context) async {
    if (!_validate()) return;

    _isLoading.value = true;
    update();

    try {
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Signed in successfully!',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Get.offAll(() => const HomeScreen());

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  // ── Forgot Password ──
  void forgotPassword(BuildContext context) {
    Get.to(() => const ForgotPasswordScreen());
  }

  // ── Sign Up ──
  void goToSignUp(BuildContext context) {
    // Get.to(() => const SignUpScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}