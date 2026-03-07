import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/customer/barber_model.dart';
import '../../models/customer/service_model.dart';

class BusinessBookingController extends GetxController {
  // ── Form Controllers ──
  final companyNameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final taxIdController = TextEditingController();

  // ── State ──
  final _selectedIndustry = RxnString();
  final _employeeCount = 5.obs;
  final _selectedService = Rxn<ServiceModel>();
  final _selectedDate = Rxn<DateTime>();
  final _selectedTime = Rxn<TimeOfDay>();
  final _isLoading = false.obs;
  final _barber = Rxn<BarberModel>();
  final _bookingType = 'business'.obs;

  // ── Form Errors ──
  final _companyError = RxnString();
  final _industryError = RxnString();
  final _contactError = RxnString();
  final _emailError = RxnString();
  final _phoneError = RxnString();

  // ── Industries ──
  final List<String> industries = const [
    'Technology',
    'Finance & Banking',
    'Healthcare',
    'Retail',
    'Manufacturing',
    'Consulting',
    'Real Estate',
    'Education',
    'Media & Entertainment',
  ];

  // ── Services (injected from profile) ──
  final List<ServiceModel> services = const [
    ServiceModel(id: 1, name: 'Standard Business Cut', description: 'Professional haircut suitable for corporate environments', price: 35, durationMinutes: 30),
    ServiceModel(id: 2, name: 'Executive Premium Cut', description: 'Premium cut with style consultation and finishing', price: 50, durationMinutes: 45, isPopular: true),
    ServiceModel(id: 3, name: 'Quick Trim & Touch-up', description: 'Fast trim to keep you looking sharp between haircuts', price: 25, durationMinutes: 20),
    ServiceModel(id: 4, name: 'Full Service Package', description: 'Haircut, beard trim, hot towel treatment & styling', price: 70, durationMinutes: 60),
  ];

  // ── Getters ──
  String? get selectedIndustry => _selectedIndustry.value;
  int get employeeCount => _employeeCount.value;
  ServiceModel? get selectedService => _selectedService.value;
  DateTime? get selectedDate => _selectedDate.value;
  TimeOfDay? get selectedTime => _selectedTime.value;
  bool get isLoading => _isLoading.value;
  BarberModel? get barber => _barber.value;
  String get bookingType => _bookingType.value;

  String? get companyError => _companyError.value;
  String? get industryError => _industryError.value;
  String? get contactError => _contactError.value;
  String? get emailError => _emailError.value;
  String? get phoneError => _phoneError.value;

  // ── Pricing ──
  double get pricePerPerson => _selectedService.value?.price ?? 50.0;
  double get subtotal => pricePerPerson * _employeeCount.value;
  double get discount => _employeeCount.value >= 10 ? subtotal * 0.10 : 0;
  double get totalAmount => subtotal - discount;
  bool get hasVolumeDiscount => _employeeCount.value >= 10;

  String get estimatedTime {
    final mins = (_selectedService.value?.durationMinutes ?? 45) * _employeeCount.value;
    final h = mins ~/ 60;
    final m = mins % 60;
    return h > 0 ? '${h}h ${m}min' : '${m}min';
  }

  String get estimatedCostLabel => 'R\$${subtotal.toStringAsFixed(0)}.00';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _barber.value = args['barber'] as BarberModel?;
      _bookingType.value = args['type'] ?? 'business';
    }
    _selectedService.value = services.first;
  }

  // ── Employee Count ──
  void incrementEmployee() {
    if (_employeeCount.value < 50) _employeeCount.value++;
  }

  void decrementEmployee() {
    if (_employeeCount.value > 1) _employeeCount.value--;
  }

  // ── Industry ──
  void selectIndustry(String industry) {
    _selectedIndustry.value = industry;
    _industryError.value = null;
    Get.back();
  }

  // ── Service ──
  void selectService(ServiceModel service) {
    _selectedService.value = service;
  }

  // ── Date & Time ──
  void selectDate(DateTime date) => _selectedDate.value = date;
  void selectTime(TimeOfDay time) => _selectedTime.value = time;

  // ── Form Validation ──
  bool _validateForm() {
    bool valid = true;
    if (companyNameController.text.trim().isEmpty) {
      _companyError.value = 'Company name is required';
      valid = false;
    } else {
      _companyError.value = null;
    }
    if (_selectedIndustry.value == null) {
      _industryError.value = 'Please select an industry';
      valid = false;
    } else {
      _industryError.value = null;
    }
    if (contactPersonController.text.trim().isEmpty) {
      _contactError.value = 'Contact person is required';
      valid = false;
    } else {
      _contactError.value = null;
    }
    if (emailController.text.trim().isEmpty) {
      _emailError.value = 'Email is required';
      valid = false;
    } else {
      _emailError.value = null;
    }
    if (phoneController.text.trim().isEmpty) {
      _phoneError.value = 'Phone is required';
      valid = false;
    } else {
      _phoneError.value = null;
    }
    return valid;
  }

  void continueToEmployeeCount() {
    if (!_validateForm()) return;
    Get.toNamed('/employee-count', arguments: {
      'barber': _barber.value,
      'type': 'business',
      'companyName': companyNameController.text.trim(),
      'industry': _selectedIndustry.value,
    });
  }

  void continueToServiceSelection() {
    Get.toNamed('/service-selection', arguments: {
      'barber': _barber.value,
      'employeeCount': _employeeCount.value,
      'type': _bookingType.value,
    });
  }

  void continueToPayment() {
    Get.toNamed('/payment-options', arguments: {
      'barber': _barber.value,
      'service': _selectedService.value,
      'employeeCount': _employeeCount.value,
      'totalAmount': totalAmount,
      'type': _bookingType.value,
    });
  }

  @override
  void onClose() {
    companyNameController.dispose();
    contactPersonController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    taxIdController.dispose();
    super.onClose();
  }
}