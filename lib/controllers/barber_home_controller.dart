import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/storage_helper.dart';
import '../models/user_model.dart';
import '../views/screens/home/barber/request/barber_request_screen.dart';
import '../views/screens/home/barber/schedule/barber_schedule_screen.dart';
import '../views/screens/home/barber/schedule/barber_start_navigation_screen.dart';

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
  final _requests = <Map<String, dynamic>>[].obs;

  // ── Getters ──
  bool get isOnline => _isOnline.value;
  bool get isLoading => _isLoading.value;
  String get earnings => _earnings.value;
  String get earningsChange => _earningsChange.value;
  String get earningsDate => _earningsDate.value;
  List<Map<String, String>> get stats => _stats;
  List<Map<String, dynamic>> get todaySchedule => _todaySchedule;
  List<Map<String, dynamic>> get scheduleAppointments => _todaySchedule;
  List<Map<String, dynamic>> get requests => _requests;
  List<Map<String, dynamic>> get previewSchedule => _todaySchedule.isNotEmpty ? [_todaySchedule.first] : [];

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
        {
          'name': 'Michael Scott',
          'service': 'Hair + Beard',
          'price': '\$50',
          'time': '3:30 PM',
          'address': '56 Oak Ave, Suite 12',
          'distance': '2.5 km away',
        },
      ];

      // ── DEV: Mock Requests ──
      _requests.value = [
        {
          'name': 'David Chen',
          'service': "Men's Haircut",
          'price': '\$35',
          'rating': '5.0',
          'avatar': null,
          'duration': '30 min',
          'time': 'Today, 2:00 PM',
          'timeNote': 'In 45 minutes',
          'address': '123 Main Street',
          'addressNote': 'Downtown, Apartment 4B',
          'distance': '1.2 km away',
          'distanceNote': '5 min drive',
          'instructions': 'Please ring doorbell twice. Have allergies, please use hypoallergenic products.',
          'serviceFee': '\$35.00',
          'platformFee': '-\$5.25',
          'youEarn': '\$29.75',
        },
        {
          'name': 'Michael Scott',
          'service': 'Hair + Beard',
          'price': '\$50',
          'rating': '5.0',
          'avatar': null,
          'duration': '45 min',
          'time': 'Today, 3:30 PM',
          'timeNote': 'In 2 hours',
          'address': '56 Oak Ave',
          'addressNote': 'Suite 12',
          'distance': '2.5 km away',
          'distanceNote': '8 min drive',
          'instructions': '',
          'serviceFee': '\$50.00',
          'platformFee': '-\$7.50',
          'youEarn': '\$42.50',
        },
      ];

      // ── PRODUCTION: uncomment ──
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
      // final rawRequests = await _api.getBarberRequests();
      // _requests.value = rawRequests;

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
    _isOnline.value = value;
    update();
    // ── PRODUCTION ──
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

  // ── Accept Request ──
  Future<void> acceptRequest(Map<String, dynamic> request) async {
    // ── DEV: local remove ──
    _requests.remove(request);
    update();

    // ── PRODUCTION: uncomment ──
    // try {
    //   await _api.acceptRequest(requestId: request['id']);
    //   _requests.remove(request);
    //   update();
    // } catch (e) {
    //   Get.snackbar('Error', e.toString(),
    //       backgroundColor: Colors.redAccent,
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  // ── Decline Request ──
  Future<void> declineRequest(Map<String, dynamic> request) async {
    // ── DEV: local remove ──
    _requests.remove(request);
    update();

    // ── PRODUCTION: uncomment ──
    // try {
    //   await _api.declineRequest(requestId: request['id']);
    //   _requests.remove(request);
    //   update();
    // } catch (e) {
    //   Get.snackbar('Error', e.toString(),
    //       backgroundColor: Colors.redAccent,
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  Future<void> goOnline() async => await toggleOnlineStatus(true);
  void goToNotifications() {}

  void goToSchedule() {
    Get.to(() => const BarberScheduleScreen(), transition: Transition.rightToLeft);
  }

  void goToRequest() {
    Get.to(() => const BarberRequestScreen(), transition: Transition.rightToLeft);
  }

  // startNavigation method update করো:
  void startNavigation(Map<String, dynamic> appointment) {
    Get.to(
          () => BarberStartNavigationScreen(appointment: appointment),
      transition: Transition.rightToLeft,
    );
  }

  void seeMoreSchedule() => goToSchedule();
}