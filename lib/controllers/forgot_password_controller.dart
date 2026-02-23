import 'dart:async';
import 'package:flutter/material.dart';

enum ForgotPasswordStep { enterEmail, enterOtp, createPassword }

class ForgotPasswordController extends ChangeNotifier {
  // ── Step ──
  ForgotPasswordStep _step = ForgotPasswordStep.enterEmail;
  ForgotPasswordStep get step => _step;

  // ── Controllers ──
  final TextEditingController emailController = TextEditingController();
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ── State ──
  bool _isLoading = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _emailError;
  String? _otpError;
  String? _passwordError;
  String _sentEmail = '';

  // ── Resend Timer ──
  int _resendSeconds = 55;
  Timer? _timer;

  // ── Getters ──
  bool get isLoading => _isLoading;
  bool get obscureNew => _obscureNew;
  bool get obscureConfirm => _obscureConfirm;
  String? get emailError => _emailError;
  String? get otpError => _otpError;
  String? get passwordError => _passwordError;
  String get sentEmail => _sentEmail;
  int get resendSeconds => _resendSeconds;
  bool get canResend => _resendSeconds == 0;

  // ── Password Rules ──
  String get password => newPasswordController.text;
  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));

  // ── Password Requirements List (UI loop এর জন্য) ──
  List<({String label, bool met})> get passwordRequirements => [
    (label: 'At least 8 characters', met: hasMinLength),
    (label: 'One uppercase letter',  met: hasUppercase),
    (label: 'One lowercase letter',  met: hasLowercase),
    (label: 'One number',            met: hasNumber),
  ];
  bool get isFormFilled => emailController.text.trim().isNotEmpty;
  bool get isOtpFilled => otpControllers.every((c) => c.text.isNotEmpty);
  bool get isPasswordFilled =>
      newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;

  ForgotPasswordController() {
    emailController.addListener(notifyListeners);
    newPasswordController.addListener(notifyListeners);
    confirmPasswordController.addListener(notifyListeners);
  }

  // ── Step 1: Send Verification Code ──
  Future<void> sendVerificationCode(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _emailError = 'Email is required';
      notifyListeners();
      return;
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _emailError = 'Enter a valid email';
      notifyListeners();
      return;
    }
    _emailError = null;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _sentEmail = email;
      _step = ForgotPasswordStep.enterOtp;
      _startResendTimer();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Step 2: Verify OTP ──
  Future<void> verifyCode(BuildContext context) async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      _otpError = 'Please enter the 6-digit code';
      notifyListeners();
      return;
    }
    _otpError = null;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _step = ForgotPasswordStep.createPassword;
      _timer?.cancel();
    } catch (e) {
      _otpError = 'Invalid code. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Step 2: Resend Code ──
  Future<void> resendCode() async {
    if (!canResend) return;
    _resendSeconds = 55;
    _startResendTimer();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
  }

  void _startResendTimer() {
    _timer?.cancel();
    _resendSeconds = 55;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds > 0) {
        _resendSeconds--;
        notifyListeners();
      } else {
        t.cancel();
      }
    });
  }

  // ── Step 3: Reset Password ──
  Future<void> resetPassword(BuildContext context) async {
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (!hasMinLength || !hasUppercase || !hasLowercase || !hasNumber) {
      _passwordError = 'Password does not meet requirements';
      notifyListeners();
      return;
    }
    if (newPass != confirmPass) {
      _passwordError = 'Passwords do not match';
      notifyListeners();
      return;
    }
    _passwordError = null;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset successful!'),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context); // back to login
      }
    } catch (e) {
      _passwordError = 'Something went wrong. Try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleObscureNew() {
    _obscureNew = !_obscureNew;
    notifyListeners();
  }

  void toggleObscureConfirm() {
    _obscureConfirm = !_obscureConfirm;
    notifyListeners();
  }

  void goToSignUp(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  @override
  void dispose() {
    _timer?.cancel();
    emailController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}