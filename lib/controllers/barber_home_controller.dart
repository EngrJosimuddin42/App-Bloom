import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/storage_helper.dart';
import '../models/user_model.dart';
import '../views/screens/home/barber/profile/reviews/barber_reviews_screen.dart';
import '../views/screens/home/barber/profile_setup/verification_complete_dialog.dart';
import '../views/screens/home/barber/request/barber_request_screen.dart';
import '../views/screens/home/barber/schedule/barber_schedule_screen.dart';
import '../views/screens/home/barber/schedule/barber_start_navigation_screen.dart';
import '../views/screens/home/barber/profile/view_earnings/barber_earning_screen.dart';

class BarberHomeController extends GetxController {

  // final _api = Get.find<ApiService>();

  // ── Dashboard State ──
  final _isOnline       = false.obs;
  final _isLoading      = false.obs;
  final _earnings       = ''.obs;
  final _earningsChange = ''.obs;
  final _earningsDate   = ''.obs;
  final _stats          = <Map<String, String>>[].obs;
  final _todaySchedule  = <Map<String, dynamic>>[].obs;
  final _requests       = <Map<String, dynamic>>[].obs;

  // ── Profile State ──
  final _avatarUrl    = ''.obs;
  final _location     = ''.obs;
  final _rating       = ''.obs;
  final _reviewCount  = ''.obs;
  final _jobsDone     = ''.obs;
  final _experience   = ''.obs;
  final _galleryImages = <String>[].obs;

  // ── Edit Profile State ──
  final _editName       = ''.obs;
  final _editEmail      = ''.obs;
  final _editPhone      = ''.obs;
  final _editIdNumber   = ''.obs;
  final _editLocation   = ''.obs;
  final _editExperience = 0.obs;
  final _notificationEnabled = true.obs;

  // ── Reviews State ──
  final _reviews         = <Map<String, dynamic>>[].obs;
  final _starCounts      = <int, int>{}.obs;
  final _overallRating   = 0.0.obs;
  final _totalReviews    = 0.obs;
  final _positivePercent = 0.obs;


  // ── Navigation State ──
  final _navAppointment   = <String, dynamic>{}.obs;
  final _navEta           = '5 minutes'.obs;
  final _navDistance      = '1.2 km'.obs;
  final _navDirection     = 'Turn right on Main Street'.obs;
  final _navDirectionNote = 'In 200 meter'.obs;
  final _navBarberLat     = 23.8103.obs;
  final _navBarberLng     = 90.4125.obs;
  final _navCustomerLat   = 23.8203.obs;
  final _navCustomerLng   = 90.4225.obs;


  // ── Dashboard Getters ──
  bool get isOnline           => _isOnline.value;
  bool get isLoading          => _isLoading.value;
  String get earnings         => _earnings.value;
  String get earningsChange   => _earningsChange.value;
  String get earningsDate     => _earningsDate.value;
  List<Map<String, String>>  get stats                => _stats;
  List<Map<String, dynamic>> get todaySchedule        => _todaySchedule;
  List<Map<String, dynamic>> get scheduleAppointments => _todaySchedule;
  List<Map<String, dynamic>> get requests             => _requests;
  List<Map<String, dynamic>> get previewSchedule      =>
      _todaySchedule.isNotEmpty ? [_todaySchedule.first] : [];

  // ── Profile Getters ──
  UserModel? get user      => StorageHelper.getUser();
  String get userName      => user?.fullName ?? 'John Smith';
  String get avatarUrl     => _avatarUrl.value;
  String get location      => _location.value;
  String get rating        => _rating.value;
  String get reviewCount   => _reviewCount.value;
  String get jobsDone      => _jobsDone.value;
  String get experience    => _experience.value;
  List<String> get galleryImages => _galleryImages;

  // ── Edit Profile Getters ──
  String get editName       => _editName.value;
  String get editEmail      => _editEmail.value;
  String get editPhone      => _editPhone.value;
  String get editIdNumber   => _editIdNumber.value;
  String get editLocation   => _editLocation.value;
  int    get editExperience => _editExperience.value;
  bool get notificationEnabled => _notificationEnabled.value;


  // ── Reviews Getters ──
  List<Map<String, dynamic>> get reviews         => _reviews;
  Map<int, int>              get starCounts      => _starCounts;
  double                     get overallRating   => _overallRating.value;
  int                        get totalReviews    => _totalReviews.value;
  int                        get positivePercent => _positivePercent.value;


  // ── Navigation Getters ──
  Map<String, dynamic> get navAppointment   => _navAppointment;
  String get navEta                         => _navEta.value;
  String get navDistance                    => _navDistance.value;
  String get navDirection                   => _navDirection.value;
  String get navDirectionNote               => _navDirectionNote.value;
  double get navBarberLat                   => _navBarberLat.value;
  double get navBarberLng                   => _navBarberLng.value;
  double get navCustomerLat                 => _navCustomerLat.value;
  double get navCustomerLng                 => _navCustomerLng.value;



  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  // ── Dashboard + Profile Data Load ──
  Future<void> loadDashboard() async {
    _isLoading.value = true;
    update();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // ── DEV: Mock Dashboard ──
      _earnings.value       = '\$1,240';
      _earningsChange.value = '+18% from last week';
      _earningsDate.value   = '09/25';
      _isOnline.value       = true;

      _stats.value = [
        {'icon': 'assets/images/dollar_icon.png', 'value': '\$420', 'label': 'Today'},
        {'icon': 'assets/images/bag_icon.png',    'value': '8',     'label': 'Jobs'},
        {'icon': 'assets/images/star_icon.png',   'value': '8',     'label': 'Jobs'},
        {'icon': 'assets/images/trend_icon.png',  'value': '+12%',  'label': 'Week'},
      ];

      _todaySchedule.value = [
        {
          'name': 'David Chen', 'service': "Men's Haircut",
          'price': '\$35', 'time': '02:00 PM',
          'address': '123 Main St. Apt 4B', 'distance': '1.2 km',
          'instructions': 'Please ring doorbell twice. Customer has allergies, use hypoallergenic products.',
        },
        {
          'name': 'Michael Scott', 'service': 'Hair + Beard',
          'price': '\$50', 'time': '3:30 PM',
          'address': '56 Oak Ave, Suite 12', 'distance': '2.5 km',
          'instructions': 'Please ring doorbell twice. Customer has allergies, use hypoallergenic products.',

        },
      ];

      _requests.value = [
        {
          'name': 'David Chen', 'service': "Men's Haircut",
          'price': '\$35', 'rating': '5.0', 'avatar': null,
          'duration': '30 min', 'time': 'Today, 2:00 PM',
          'timeNote': 'In 45 minutes', 'address': '123 Main Street',
          'addressNote': 'Downtown, Apartment 4B', 'distance': '1.2 km away',
          'distanceNote': '5 min drive',
          'instructions': 'Please ring doorbell twice. Have allergies, please use hypoallergenic products.',
          'serviceFee': '\$35.00', 'platformFee': '-\$5.25', 'youEarn': '\$29.75',
        },
        {
          'name': 'Michael Scott', 'service': 'Hair + Beard',
          'price': '\$50', 'rating': '5.0', 'avatar': null,
          'duration': '45 min', 'time': 'Today, 3:30 PM',
          'timeNote': 'In 2 hours', 'address': '56 Oak Ave',
          'addressNote': 'Suite 12', 'distance': '2.5 km away',
          'distanceNote': '8 min drive', 'instructions': '',
          'serviceFee': '\$50.00', 'platformFee': '-\$7.50', 'youEarn': '\$42.50',
        },
      ];

      // ── DEV: Mock Profile ──
      _avatarUrl.value   = 'https://i.pravatar.cc/150?img=12';
      _location.value    = 'New York, USA';
      _rating.value      = '5';
      _reviewCount.value = '127 reviews';
      _jobsDone.value    = '856';
      _experience.value  = '8 Years';
      _galleryImages.value = [
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
        'https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=300',
        'https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=300',
        'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=300',
        'https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=300',
        'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
      ];

      // ── DEV: Mock Edit Profile ──
      _editName.value       = 'Josimuddin';
      _editEmail.value      = 'josimcse@gmail.com';
      _editPhone.value      = '+880 | 0173 866 43 82';
      _editIdNumber.value   = '000 000 000';
      _editLocation.value   = 'Mohakhali, Dhaka, Bangladesh 1212';
      _editExperience.value = 1;


      // ── DEV: Mock Reviews ──
      _overallRating.value   = 4.9;
      _totalReviews.value    = 247;
      _positivePercent.value = 98;
      _starCounts.value      = {5: 215, 4: 25, 3: 5, 2: 2, 1: 0};
      _reviews.value = [
        {
          'name': 'David Chen',
          'avatar': 'https://i.pravatar.cc/150?img=8',
          'service': "Men's Haircut",
          'date': '2 days ago',
          'userRating': 3,
        },
        {
          'name': 'Michael Scott',
          'avatar': 'https://i.pravatar.cc/150?img=14',
          'service': 'Hair + Beard',
          'date': '5 days ago',
          'userRating': 4,
        },
      ];

      // ── PRODUCTION: uncomment ──
      // final dash = await _api.getBarberDashboard();
      // _earnings.value       = dash['earnings'] ?? '\$0';
      // _earningsChange.value = dash['earnings_change'] ?? '';
      // _earningsDate.value   = dash['earnings_date'] ?? '';
      // _isOnline.value       = dash['is_online'] ?? false;
      // final rawStats = dash['stats'] as List? ?? [];
      // _stats.value = rawStats.map<Map<String, String>>((s) => {
      //   'icon': s['icon'] ?? '', 'value': s['value'] ?? '', 'label': s['label'] ?? '',
      // }).toList();
      // final rawSchedule = dash['today_schedule'] as List? ?? [];
      // _todaySchedule.value = rawSchedule.map<Map<String, dynamic>>((s) => Map<String, dynamic>.from(s)).toList();
      // final rawRequests = await _api.getBarberRequests();
      // _requests.value = rawRequests;
      //
      // final profile = await _api.getBarberProfile();
      // _avatarUrl.value      = profile['avatar_url'] ?? '';
      // _location.value       = profile['location'] ?? '';
      // _rating.value         = profile['rating'] ?? '0';
      // _reviewCount.value    = '${profile['review_count'] ?? 0} reviews';
      // _jobsDone.value       = '${profile['jobs_done'] ?? 0}';
      // _experience.value     = '${profile['experience_years'] ?? 0} Years';
      // _galleryImages.value  = List<String>.from(profile['gallery'] ?? []);
      // _editName.value       = profile['name'] ?? '';
      // _editEmail.value      = profile['email'] ?? '';
      // _editPhone.value      = profile['phone'] ?? '';
      // _editIdNumber.value   = profile['id_number'] ?? '';
      // _editLocation.value   = profile['location'] ?? '';
      // _editExperience.value = profile['experience_years'] ?? 0;

    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  // ── Online Toggle ──
  Future<void> toggleOnlineStatus(bool value) async {
    _isOnline.value = value;
    update();
    // ── PRODUCTION ──
    // try {
    //   await _api.updateOnlineStatus(isOnline: value);
    // } catch (e) {
    //   _isOnline.value = !value;
    //   update();
    //   Get.snackbar('Error', e.toString(), ...);
    // }
  }

  // ── Accept / Decline Request ──
  Future<void> acceptRequest(Map<String, dynamic> request) async {
    _requests.remove(request);
    update();
    // ── PRODUCTION: await _api.acceptRequest(requestId: request['id']); ──
  }

  Future<void> declineRequest(Map<String, dynamic> request) async {
    _requests.remove(request);
    update();
    // ── PRODUCTION: await _api.declineRequest(requestId: request['id']); ──
  }

  // ── Gallery ──
  void deleteGalleryImage(int index) {
    _galleryImages.removeAt(index);
    update();
    // PRODUCTION: await _api.deleteGalleryImage(imageId);
  }

  // ── Reviews ──
  void updateReviewRating(int index, int stars) {
    final updated = List<Map<String, dynamic>>.from(_reviews);
    updated[index] = {...updated[index], 'userRating': stars};
    _reviews.value = updated;
    update();
    // PRODUCTION: await _api.submitReviewRating(reviewId: _reviews[index]['id'], stars: stars);
  }


  // ── Edit Profile Actions ──
  void incrementExperience() {
    _editExperience.value++;
    update();
  }

  void toggleNotification(bool value) {
    _notificationEnabled.value = value;
    update();
    // PRODUCTION: await _api.updateNotificationSetting(value);
  }

  void decrementExperience() {
    if (_editExperience.value > 0) {
      _editExperience.value--;
      update();
    }
  }

  void saveProfile({
    required String name,
    required String email,
    required String phone,
    required String idNumber,
    required String location,
  }) {
    _editName.value     = name;
    _editEmail.value    = email;
    _editPhone.value    = phone;
    _editIdNumber.value = idNumber;
    _editLocation.value = location;
    _location.value     = location;
    update();
    Get.back();
    // PRODUCTION: await _api.updateProfile(...);
  }

  // ── Navigation Actions ──
  void startNavigation(Map<String, dynamic> appointment) {
    // ── DEV: Mock navigation data ──
    _navAppointment.value   = appointment;
    _navEta.value           = '5 minutes';
    _navDistance.value      = appointment['distance'] ?? '1.2 km';
    _navDirection.value     = 'Turn right on Main Street';
    _navDirectionNote.value = 'In 200 meter';
    _navBarberLat.value     = 23.8103;
    _navBarberLng.value     = 90.4125;
    _navCustomerLat.value   = 23.8203;
    _navCustomerLng.value   = 90.4225;

    // ── PRODUCTION: uncomment ──
    // final nav = await _api.getNavigationData(appointmentId: appointment['id']);
    // _navAppointment.value   = appointment;
    // _navEta.value           = nav['eta'] ?? '5 minutes';
    // _navDistance.value      = nav['distance'] ?? '1.2 km';
    // _navDirection.value     = nav['next_direction'] ?? '';
    // _navDirectionNote.value = nav['direction_note'] ?? '';
    // _navBarberLat.value     = nav['barber_lat'];
    // _navBarberLng.value     = nav['barber_lng'];
    // _navCustomerLat.value   = nav['customer_lat'];
    // _navCustomerLng.value   = nav['customer_lng'];

    Get.to(
          () => const BarberStartNavigationScreen(),
      transition: Transition.rightToLeft,
    );
  }

  // ── Application State ──
  final _applicationId = ''.obs;
  String get applicationId => _applicationId.value;

// ── applicationId set করার method ──
  void setApplicationId(String id) {
    _applicationId.value = id;
    update();
  }

// ── Navigation ──
  void goToVerify() {
    VerificationCompleteDialog.show(
      onOk: () => Get.back(),
    );
  }

  Future<void> goOnline() async => await toggleOnlineStatus(true);
  void goToNotifications() {}

  void goToSchedule() =>
      Get.to(() => const BarberScheduleScreen(), transition: Transition.rightToLeft);

  void goToRequest() =>
      Get.to(() => const BarberRequestScreen(), transition: Transition.rightToLeft);

  void goToEarnings() =>
      Get.to(() => const BarberEarningScreen(), transition: Transition.rightToLeft);

  void goToReviews() {
    Get.to(() => const BarberReviewsScreen(), transition: Transition.rightToLeft);
  }

  void seeMoreSchedule() => goToSchedule();
}