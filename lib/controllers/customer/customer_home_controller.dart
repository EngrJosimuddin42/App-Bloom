import 'package:get/get.dart';
import '../../models/customer/review_model.dart';
import '../../models/customer/barber_model.dart';
import '../../services/api_service.dart';

class CustomerHomeController extends GetxController {
  final _api = Get.find<ApiService>();

  // ── State ──
  final _isLoading = false.obs;
  final _nearbyBarbers = <BarberModel>[].obs;
  final _eta = '5 minutes'.obs;
  final _distance = '1.2 km'.obs;

  // ── Getters ──
  bool get isLoading => _isLoading.value;
  List<BarberModel> get nearbyBarbers => _nearbyBarbers;
  String get eta => _eta.value;
  String get distance => _distance.value;

  // ── Mock Data ──
  final List<BarberModel> _mockBarbers = [
    BarberModel(
      id: 1,
      firstName: 'Marcus',
      lastName: 'Johnson',
      title: 'Master Barber',
      experience: 6,
      location: 'New York, NY',
      distance: 1.3,
      rating: 4.8,
      reviewCount: 247,
      totalBookings: 247,
      startingPrice: 350,
      nextAvailable: 'In 15 minutes',
      isAvailable: true,
      isLicensed: true,
      isBackgroundVerified: true,
      isCovidVaccinated: true,
      specialties: ['Classic and modern cut'],
      reviews: [
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '2 days ago'),
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '3 days ago'),
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '7 days ago'),
      ],
    ),
    BarberModel(
      id: 2,
      firstName: 'Marcus',
      lastName: 'Johnson',
      title: '100+ Residential haircuts',
      experience: 5,
      location: 'New York, NY',
      distance: 2.1,
      rating: 5.0,
      reviewCount: 182,
      totalBookings: 182,
      startingPrice: 350,
      nextAvailable: 'In 30 minutes',
      isAvailable: true,
    ),
    BarberModel(
      id: 3,
      firstName: 'Marcus',
      lastName: 'Johnson',
      title: 'Fade specialist, 270 cuts',
      experience: 8,
      location: 'New York, NY',
      distance: 3.0,
      rating: 5.0,
      reviewCount: 270,
      totalBookings: 270,
      startingPrice: 350,
      nextAvailable: 'Tomorrow',
      isAvailable: false,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadNearbyBarbers();
  }

  Future<void> loadNearbyBarbers() async {
    _isLoading.value = true;
    // ── DEV MODE ──
    await Future.delayed(const Duration(milliseconds: 600));
    _nearbyBarbers.assignAll(_mockBarbers);
    _isLoading.value = false;

    // ── PRODUCTION: uncomment ──
    // try {
    //   final data = await _api.getNearbyBarbers();
    //   _nearbyBarbers.assignAll(data.map((e) => BarberModel.fromJson(e)));
    // } catch (e) {
    //   // handle error
    // } finally {
    //   _isLoading.value = false;
    // }
  }

  void goToBarberProfile(BarberModel barber) {
    Get.toNamed('/barber-profile', arguments: barber);
  }

  void requestBarber() {
    Get.toNamed('/barber-profile', arguments: _mockBarbers.first);
  }

  void goToMyBookings() {
    Get.toNamed('/my-bookings');
  }

  void goToProfile() {
    Get.toNamed('/customer-profile');
  }

  void goToWallet() {
    Get.toNamed('/wallet');
  }

  void goToMembership() {
    Get.toNamed('/membership');
  }
}