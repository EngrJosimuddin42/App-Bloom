import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ForgotPasswordStep { enterEmail, enterOtp, createPassword }

class ForgotPasswordController extends GetxController {

  // ── Controllers ──
  final emailController = TextEditingController();
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController(text: '0'));
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ── State ──
  final _step = ForgotPasswordStep.enterEmail.obs;
  final _isLoading = false.obs;
  final _obscureNew = true.obs;
  final _obscureConfirm = true.obs;
  final _emailError = RxnString();
  final _otpError = RxnString();
  final _passwordError = RxnString();
  final _sentEmail = ''.obs;
  final _resendSeconds = 55.obs;

  Timer? _timer;

  // ── Getters ──
  ForgotPasswordStep get step => _step.value;
  bool get isLoading => _isLoading.value;
  bool get obscureNew => _obscureNew.value;
  bool get obscureConfirm => _obscureConfirm.value;
  String? get emailError => _emailError.value;
  String? get otpError => _otpError.value;
  String? get passwordError => _passwordError.value;
  String get sentEmail => _sentEmail.value;
  int get resendSeconds => _resendSeconds.value;
  bool get canResend => _resendSeconds.value == 0;

  // ── Password Rules ──
  String get password => newPasswordController.text;
  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));

  List<({String label, bool met})> get passwordRequirements => [
    (label: 'At least 8 characters', met: hasMinLength),
    (label: 'One uppercase letter', met: hasUppercase),
    (label: 'One lowercase letter', met: hasLowercase),
    (label: 'One number', met: hasNumber),
  ];

  bool get isFormFilled => emailController.text.trim().isNotEmpty;
  bool get isOtpFilled => otpControllers.every((c) => c.text.isNotEmpty);
  bool get isPasswordFilled =>
      newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(update);
    newPasswordController.addListener(update);
    confirmPasswordController.addListener(update);
  }

  // ── Step 1: Send Verification Code ──
  Future<void> sendVerificationCode() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _emailError.value = 'Email is required';
      return;
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _emailError.value = 'Enter a valid email';
      return;
    }
    _emailError.value = null;

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));
      _sentEmail.value = email;
      _step.value = ForgotPasswordStep.enterOtp;
      _startResendTimer();
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
    }
  }

  // ── Step 2: Verify OTP ──
  Future<void> verifyCode() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      _otpError.value = 'Please enter the 6-digit code';
      return;
    }
    _otpError.value = null;

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));
      _step.value = ForgotPasswordStep.createPassword;
      _timer?.cancel();
    } catch (e) {
      _otpError.value = 'Invalid code. Please try again.';
    } finally {
      _isLoading.value = false;
    }
  }

  // ── Step 2: Resend Code ──
  Future<void> resendCode() async {
    if (!canResend) return;
    _resendSeconds.value = 55;
    _startResendTimer();
    await Future.delayed(const Duration(seconds: 1));
  }

  void _startResendTimer() {
    _timer?.cancel();
    _resendSeconds.value = 55;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds.value > 0) {
        _resendSeconds.value--;
      } else {
        t.cancel();
      }
    });
  }

  // ── Step 3: Reset Password ──
  Future<void> resetPassword() async {
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (!hasMinLength || !hasUppercase || !hasLowercase || !hasNumber) {
      _passwordError.value = 'Password does not meet requirements';
      return;
    }
    if (newPass != confirmPass) {
      _passwordError.value = 'Passwords do not match';
      return;
    }
    _passwordError.value = null;

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Password reset successful!',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back(); // back to login
    } catch (e) {
      _passwordError.value = 'Something went wrong. Try again.';
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleObscureNew() => _obscureNew.value = !_obscureNew.value;
  void toggleObscureConfirm() => _obscureConfirm.value = !_obscureConfirm.value;

  void goToSignUp() {
    // Get.to(() => const SignUpScreen());
  }

  @override
  void onClose() {
    _timer?.cancel();
    emailController.dispose();
    for (final c in otpControllers) c.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}