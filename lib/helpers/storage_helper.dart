import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class StorageHelper {
  static final _box = GetStorage();

  // ── Keys ──
  static const _tokenKey      = 'auth_token';
  static const _userKey       = 'user_data';
  static const _isLoggedInKey = 'is_logged_in';
  static const _onboardingKey = 'onboarding_done';
  static const _roleKey       = 'user_role';

  // ── DEV CONFIG ──
  // Register না করে সরাসরি login করলে এই role use হবে
  // 'barber' বা 'customer' set করুন
  static const String _devDefaultRole = 'customer';

  // ── Token ──
  static void saveToken(String token) => _box.write(_tokenKey, token);
  static String? getToken()           => _box.read<String>(_tokenKey);
  static void removeToken()           => _box.remove(_tokenKey);

  // ── User ──
  static void saveUser(UserModel user) {
    _box.write(_userKey, jsonEncode(user.toJson()));
  }

  static UserModel? getUser() {
    final data = _box.read<String>(_userKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  static void removeUser() => _box.remove(_userKey);

  // ── Role ──
  static void saveRole(String role) => _box.write(_roleKey, role);
  static String getRole() {
    return _devDefaultRole;
    // ── PRODUCTION: উপরের line comment করে নিচেরটা uncomment
    // return _box.read<String>(_roleKey) ?? _devDefaultRole;
  }
  // ── Login Status ──
  static void setLoggedIn(bool value) => _box.write(_isLoggedInKey, value);
  static bool isLoggedIn()            => _box.read<bool>(_isLoggedInKey) ?? false;

  // ── Onboarding ──
  static void setOnboardingDone() => _box.write(_onboardingKey, true);
  static bool isOnboardingDone()  => _box.read<bool>(_onboardingKey) ?? false;

  static void clearAll() {
    _box.remove(_tokenKey);
    _box.remove(_userKey);
    _box.remove(_isLoggedInKey);
  }
}