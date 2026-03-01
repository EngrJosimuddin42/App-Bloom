import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/storage_helper.dart';
import '../models/user_model.dart';
// import '../services/api_service.dart';

class BarberHomeController extends GetxController {

  // final _api = Get.find<ApiService>();

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
  String get userName => user?.fullName ?? 'Marcus Johnson';

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
      // ── DEV: Mock Data ──
      await Future.delayed(const Duration(milliseconds: 500));

      _earnings.value = '\$1,240';
      _earningsChange.value = '+18% from last week';
      _earningsDate.value = '09/25';
      _isOnline.value = false;

      _stats.value = [
        {'icon': 'assets/images/dollar_icon.png', 'value': '\$420', 'label': 'Today'},
        {'icon': 'assets/images/bag_icon.png',    'value': '8',     'label': 'Jobs'},
        {'icon': 'assets/images/star_icon.png',   'value': '8',     'label': 'Jobs'},
        {'icon': 'assets/images/trend_icon.png',  'value': '+12%',  'label': 'Week'},
      ];

      _todaySchedule.value = [
        {
          'name': 'David Chen',
          'service': "Men's Haircut",
          'price': '\$35',
          'time': '02:00 PM',
          'address': '123 Main St. Apt 4B',
          'distance': '1.2 km away',
        },
      ];

      // ── PRODUCTION: API Call ──
      // final data = await _api.getBarberDashboard();
      // _earnings.value = data['earnings'] ?? '\$0';
      // _earningsChange.value = data['earnings_change'] ?? '';
      // _earningsDate.value = data['earnings_date'] ?? '';
      // _isOnline.value = data['is_online'] ?? false;
      // final rawStats = data['stats'] as List? ?? [];
      // _stats.value = rawStats.map<Map<String, String>>((s) => {
      //   'icon': s['icon'] ?? '',
      //   'value': s['value'] ?? '',
      //   'label': s['label'] ?? '',
      // }).toList();
      // final rawSchedule = data['today_schedule'] as List? ?? [];
      // _todaySchedule.value = rawSchedule
      //     .map<Map<String, dynamic>>((s) => Map<String, dynamic>.from(s))
      //     .toList();

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
    // ── DEV: Local only ──
    _isOnline.value = value;
    update();

    // ── PRODUCTION: API Call ──
    // try {
    //   await _api.updateOnlineStatus(isOnline: value);
    //   _isOnline.value = value;
    //   update();
    // } catch (e) {
    //   Get.snackbar('Error', e.toString(),
    //       backgroundColor: Colors.redAccent,
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM);
    // }
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