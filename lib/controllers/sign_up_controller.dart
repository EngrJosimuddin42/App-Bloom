import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../views/screens/login_screen.dart';

enum UserRole { customer, barber }

class SignUpController extends GetxController {

  final _api = Get.find<ApiService>();

  // ── Controllers ──
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController(text: '0'));

  // ── State ──
  final _role = UserRole.customer.obs;
  final _isLoading = false.obs;
  final _obscurePassword = true.obs;
  final _obscureConfirm = true.obs;
  final _sentEmail = ''.obs;
  final List<bool> _otpTouched = List.generate(6, (_) => false);
  final _resendSeconds = 55.obs;
  final _firstNameError = RxnString();
  final _lastNameError = RxnString();
  final _emailError = RxnString();
  final _passwordError = RxnString();
  final _confirmError = RxnString();
  final _otpError = RxnString();

  Timer? _timer;

  // ── Getters ──
  UserRole get role => _role.value;
  bool get isCustomer => _role.value == UserRole.customer;
  bool get isLoading => _isLoading.value;
  bool get obscurePassword => _obscurePassword.value;
  bool get obscureConfirm => _obscureConfirm.value;
  String get sentEmail => _sentEmail.value;
  int get resendSeconds => _resendSeconds.value;
  bool get canResend => _resendSeconds.value == 0;

  String? get firstNameError => _firstNameError.value;
  String? get lastNameError => _lastNameError.value;
  String? get emailError => _emailError.value;
  String? get passwordError => _passwordError.value;
  String? get confirmError => _confirmError.value;
  String? get otpError => _otpError.value;

  bool get isFormFilled =>
      firstNameController.text.trim().isNotEmpty &&
          lastNameController.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;

  bool get isOtpFilled => _otpTouched.every((touched) => touched);


  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(update);
    lastNameController.addListener(update);
    emailController.addListener(update);
    passwordController.addListener(update);
    confirmPasswordController.addListener(update);
  }

  // ── Role Select ──
  void selectRole(UserRole selectedRole) {
    _role.value = selectedRole;
    update();
  }

  // ── Toggle Visibility ──
  void toggleObscurePassword() {
    _obscurePassword.value = !_obscurePassword.value;
    update();
  }

  void toggleObscureConfirm() {
    _obscureConfirm.value = !_obscureConfirm.value;
    update();
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      _otpTouched[index] = true;
    } else {
      _otpTouched[index] = false;
    }
    update();
  }

  // ── Validation ──
  bool _validate() {
    bool valid = true;

    if (firstNameController.text.trim().isEmpty) {
      _firstNameError.value = 'First name is required';
      valid = false;
    } else {
      _firstNameError.value = null;
    }

    if (lastNameController.text.trim().isEmpty) {
      _lastNameError.value = 'Last name is required';
      valid = false;
    } else {
      _lastNameError.value = null;
    }

    final email = emailController.text.trim();
    if (email.isEmpty) {
      _emailError.value = 'Email is required';
      valid = false;
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _emailError.value = 'Enter a valid email';
      valid = false;
    } else {
      _emailError.value = null;
    }

    if (passwordController.text.isEmpty) {
      _passwordError.value = 'Password is required';
      valid = false;
    } else if (passwordController.text.length < 8) {
      _passwordError.value = 'Minimum 8 characters';
      valid = false;
    } else {
      _passwordError.value = null;
    }

    if (confirmPasswordController.text.isEmpty) {
      _confirmError.value = 'Please confirm your password';
      valid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      _confirmError.value = 'Passwords do not match';
      valid = false;
    } else {
      _confirmError.value = null;
    }

    update();
    return valid;
  }

  // ── Step 1: Create Account ──
  Future<void> createAccount() async {
    if (!_validate()) return;

    _isLoading.value = true;
    update();

    try {
      await _api.signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        role: isCustomer ? 'customer' : 'barber',
      );
      _sentEmail.value = emailController.text.trim();
      _startResendTimer();
      Get.toNamed('/signup-otp');
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

  // ── Step 2: Verify OTP ──
  Future<void> verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      _otpError.value = 'Please enter the 6-digit code';
      update();
      return;
    }
    _otpError.value = null;
    _isLoading.value = true;
    update();

    try {
      await _api.verifySignUpOtp(
        email: _sentEmail.value,
        otp: otp,
      );
      _timer?.cancel();
      Get.toNamed('/signup-success');
    } catch (e) {
      _otpError.value = e.toString();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  // ── Resend OTP ──
  Future<void> resendCode() async {
    if (!canResend) return;
    try {
      await _api.signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: _sentEmail.value,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        role: isCustomer ? 'customer' : 'barber',
      );
      _startResendTimer();
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
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

  void goToLogin() {
    Get.offAll(() => const LoginScreen());
  }

  @override
  void onClose() {
    _timer?.cancel();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    super.onClose();
  }
}