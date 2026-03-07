import 'package:get/get.dart';
import '../../models/customer/barber_model.dart';
import '../../models/customer/service_model.dart';


class BarberProfileController extends GetxController {
  // ── State ──
  final _barber = Rxn<BarberModel>();
  final _isLoading = false.obs;

  // ── Getters ──
  BarberModel? get barber => _barber.value;
  bool get isLoading => _isLoading.value;

  // ── Mock Services ──
  final List<ServiceModel> services = const [
    ServiceModel(
      id: 1,
      name: 'Standard Business Cut',
      description: 'Professional haircut suitable for corporate environments',
      price: 35,
      durationMinutes: 30,
    ),
    ServiceModel(
      id: 2,
      name: 'Executive Premium Cut',
      description: 'Premium cut with style consultation and finishing',
      price: 50,
      durationMinutes: 45,
      isPopular: true,
    ),
    ServiceModel(
      id: 3,
      name: 'Quick Trim & Touch-up',
      description: 'Fast trim to keep you looking sharp between haircuts',
      price: 25,
      durationMinutes: 20,
    ),
    ServiceModel(
      id: 4,
      name: 'Full Service Package',
      description: 'Haircut, beard trim, hot towel treatment & styling',
      price: 70,
      durationMinutes: 60,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is BarberModel) {
      _barber.value = args;
    }
  }
}