import 'package:dio/dio.dart';
import '../helpers/storage_helper.dart';
import '../models/user_model.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // ── Base URL এখানে change করো ──
  static const String _baseUrl = 'https://your-api.com/api';

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(_AuthInterceptor());

  // ─────────────────────────────────────────
  //  AUTH
  // ─────────────────────────────────────────

  // ── Login ──
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      // API response structure অনুযায়ী adjust করো
      final data = response.data['data'] ?? response.data;
      final user = UserModel.fromJson(data['user']);
      final token = data['token'];

      // Storage এ save করো
      StorageHelper.saveToken(token);
      StorageHelper.saveUser(user);
      StorageHelper.setLoggedIn(true);

      return user;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Logout ──
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {
      // Server error হলেও local data clear করবো
    } finally {
      StorageHelper.clearAll();
    }
  }

  // ── Sign Up: Account Create ──
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role, // 'customer' or 'barber'
  }) async {
    try {
      await _dio.post(
        '/auth/register',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'role': role,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Sign Up: OTP Verify + Token Save ──
  Future<UserModel> verifySignUpOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/verify-email',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      final data = response.data['data'] ?? response.data;
      final user = UserModel.fromJson(data['user']);
      final token = data['token'];

      StorageHelper.saveToken(token);
      StorageHelper.saveUser(user);
      StorageHelper.setLoggedIn(true);

      return user;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Forgot Password: Email পাঠানো ──
  Future<void> sendResetEmail({required String email}) async {
    try {
      await _dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Forgot Password: OTP Verify ──
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await _dio.post(
        '/auth/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Forgot Password: নতুন Password Set ──
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _dio.post(
        '/auth/reset-password',
        data: {
          'email': email,
          'otp': otp,
          'password': newPassword,
          'password_confirmation': confirmPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ─────────────────────────────────────────
  //  BARBER
  // ─────────────────────────────────────────

  // ── Barber: Dashboard Data ──
  Future<Map<String, dynamic>> getBarberDashboard() async {
    try {
      final response = await _dio.get('/barber/dashboard');
      return response.data['data'] ?? response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Barber: Online Status Toggle ──
  Future<void> updateOnlineStatus({required bool isOnline}) async {
    try {
      await _dio.post(
        '/barber/status',
        data: {'is_online': isOnline},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ─────────────────────────────────────────
  //  Error Handler
  // ─────────────────────────────────────────
  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Something went wrong.';
        if (statusCode == 401) return 'Invalid email or password.';
        if (statusCode == 422) return message.toString();
        if (statusCode == 404) return 'User not found.';
        if (statusCode == 429) return 'Too many attempts. Try later.';
        return message.toString();
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

// ─────────────────────────────────────────
//  Auth Interceptor (Token auto attach)
// ─────────────────────────────────────────
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = StorageHelper.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 401 আসলে logout করে login screen এ পাঠাও
    if (err.response?.statusCode == 401) {
      StorageHelper.clearAll();
      // Get.offAllNamed('/login'); // route setup থাকলে uncomment করো
    }
    handler.next(err);
  }
}