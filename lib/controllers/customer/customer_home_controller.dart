import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../models/customer/review_model.dart';
import '../../models/customer/barber_model.dart';
import '../../services/api_service.dart';
import '../../views/screens/home/customer/customer_barber_profile_screen.dart';
import '../../views/screens/home/customer/membership_screen.dart';
import '../../views/screens/home/customer/request_barber_screen.dart';
import '../../views/screens/home/customer/wallet_screen.dart';

class CustomerHomeController extends GetxController {
  final _api = Get.find<ApiService>();

  // ── State ──
  final _isLoading        = false.obs;
  final _nearbyBarbers    = <BarberModel>[].obs;
  final _eta              = ''.obs;
  final _distance         = ''.obs;
  final _locationName     = ''.obs;
  final _barbersNearby    = ''.obs;
  final _barberLat        = 0.0.obs;
  final _barberLng        = 0.0.obs;
  final _customerLat      = 0.0.obs;
  final _customerLng      = 0.0.obs;

  // ── Getters ──
  bool get isLoading              => _isLoading.value;
  List<BarberModel> get nearbyBarbers => _nearbyBarbers;
  String get eta                  => _eta.value;
  String get distance             => _distance.value;
  String get locationName         => _locationName.value;
  String get barbersNearby        => _barbersNearby.value;
  LatLng get barberLocation       => LatLng(_barberLat.value, _barberLng.value);
  LatLng get customerLocation     => LatLng(_customerLat.value, _customerLng.value);

  // ── Mock Barbers ──
  final List<BarberModel> _mockBarbers = [
    BarberModel(
      id: 1,
      firstName: 'Marcus',
      lastName: 'Johnson',
      title: 'Fully trained and verified',
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
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      reviews: [
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '2 days ago'),
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '3 days ago'),
        ReviewModel(reviewerName: 'John Smith', rating: 5, timeAgo: '7 days ago'),
      ],
    ),
    BarberModel(
      id: 2,
      firstName: 'David',
      lastName: 'Chen',
      title: '200+ five star haircuts',
      experience: 5,
      location: 'New York, NY',
      distance: 2.1,
      rating: 5.0,
      reviewCount: 182,
      totalBookings: 182,
      startingPrice: 330,
      nextAvailable: 'In 30 minutes',
      isAvailable: true,
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
    ),
    BarberModel(
      id: 3,
      firstName: 'Michael',
      lastName: 'Scott',
      title: '10+ years experience , VIP clients',
      experience: 8,
      location: 'New York, NY',
      distance: 3.0,
      rating: 5.0,
      reviewCount: 270,
      totalBookings: 270,
      startingPrice: 300,
      nextAvailable: 'Tomorrow',
      isAvailable: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=14',

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
    _eta.value           = '5 minutes';
    _distance.value      = '1.2 km';
    _locationName.value  = 'New York, NY';
    _barbersNearby.value = '5 barbers nearby';
    _barberLat.value     = 23.8103;
    _barberLng.value     = 90.4125;
    _customerLat.value   = 23.8203;
    _customerLng.value   = 90.4225;
    _isLoading.value     = false;

    // ── PRODUCTION: uncomment ──
    // try {
    //   final data = await _api.getNearbyBarbers();
    //   _nearbyBarbers.assignAll(data['barbers'].map((e) => BarberModel.fromJson(e)));
    //   _eta.value           = data['eta'] ?? '';
    //   _distance.value      = data['distance'] ?? '';
    //   _locationName.value  = data['location_name'] ?? '';
    //   _barbersNearby.value = '${data['barbers_nearby'] ?? 0} barbers nearby';
    //   _barberLat.value     = data['barber_lat'];
    //   _barberLng.value     = data['barber_lng'];
    //   _customerLat.value   = data['customer_lat'];
    //   _customerLng.value   = data['customer_lng'];
    // } catch (e) {
    //   // handle error
    // } finally {
    //   _isLoading.value = false;
    // }
  }

  void goToBarberProfile(BarberModel barber) {
    Get.to(
          () => const CustomerBarberProfileScreen(),
      arguments: barber,
    );
  }

  void requestBarber() {
    Get.to(() => const RequestBarberScreen());
  }

  void goToMyBookings() => Get.toNamed('/my-bookings');
  void goToProfile()    => Get.toNamed('/customer-profile');
  void goToWallet() => Get.to(() => const WalletScreen());
  void goToMembership() => Get.to(() => const MembershipScreen());
}