import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/storage_helper.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class BarberHomeController extends GetxController {

  final _api = Get.find<ApiService>();

  // ── State ──
  final _isOnline = false.obs;
  final _isLoading = false.obs;
  final _earnings = ''.obs;
  final _earningsChange = ''.obs;
  final _earningsDate = ''.obs;
  final _stats = <Map<String, String>>[].obs;
  final _todaySchedule = <Map<String, dynamic>>[].obs;

  // ── Getters ──
  bool get isOnline => _isOnline.value;
  bool get isLoading => _isLoading.value;
  String get earnings => _earnings.value;
  String get earningsChange => _earningsChange.value;
  String get earningsDate => _earningsDate.value;
  List<Map<String, String>> get stats => _stats;
  List<Map<String, dynamic>> get todaySchedule => _todaySchedule;

  UserModel? get user => StorageHelper.getUser();
  String get userName => user?.fullName ?? 'Barber';

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  // ── Dashboard Data Load ──
  Future<void> loadDashboard() async {
    _isLoading.value = true;
    update();

    try {
      final data = await _api.getBarberDashboard();

      _earnings.value = data['earnings'] ?? '\$0';
      _earningsChange.value = data['earnings_change'] ?? '';
      _earningsDate.value = data['earnings_date'] ?? '';
      _isOnline.value = data['is_online'] ?? false;

      // Stats
      final rawStats = data['stats'] as List? ?? [];
      _stats.value = rawStats
          .map<Map<String, String>>((s) => {
        'icon': s['icon'] ?? '',
        'value': s['value'] ?? '',
        'label': s['label'] ?? '',
      })
          .toList();

      // Schedule
      final rawSchedule = data['today_schedule'] as List? ?? [];
      _todaySchedule.value = rawSchedule
          .map<Map<String, dynamic>>((s) => Map<String, dynamic>.from(s))
          .toList();
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

  // ── Online Status Toggle ──
  Future<void> toggleOnlineStatus(bool value) async {
    try {
      await _api.updateOnlineStatus(isOnline: value);
      _isOnline.value = value;
      update();
    } catch (e) {
      // Error হলে toggle revert করো
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> goOnline() async {
    await toggleOnlineStatus(true);
  }

  void goToNotifications() {
    // Get.to(() => const NotificationsScreen());
  }

  void goToSchedule() {
    // Get.to(() => const ScheduleScreen());
  }

  void startNavigation(Map<String, dynamic> appointment) {
    // Launch maps
  }

  void seeMoreSchedule() {
    // Get.to(() => const FullScheduleScreen());
  }
}