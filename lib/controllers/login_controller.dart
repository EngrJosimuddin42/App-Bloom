import 'package:flutter/material.dart';
import '../views/screens/forgot_password/forgot_password_screen.dart';

class LoginController extends ChangeNotifier {
  LoginController() {
    emailController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
  }

  // ── Controllers ──
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ── State ──
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  // ── Getters ──
  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  bool get isFormFilled =>
      emailController.text.trim().isNotEmpty &&
          passwordController.text.isNotEmpty;

  // ── Toggle Password Visibility ──
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // ── Validation ──
  bool _validate() {
    bool isValid = true;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      _emailError = 'Email is required';
      isValid = false;
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      _emailError = 'Enter a valid email';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = 'Minimum 6 characters';
      isValid = false;
    } else {
      _passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  // ── Sign In ──
  Future<void> signIn(BuildContext context) async {
    if (!_validate()) return;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signed in successfully!'),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Forgot Password ──
  void forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  // ── Sign Up ──
  void goToSignUp(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}