import 'review_model.dart';

class BarberModel {
  final int id;
  final String firstName;
  final String lastName;
  final String profileImage;
  final String title;
  final int experience;
  final String location;
  final double distance;
  final double rating;
  final int reviewCount;
  final int totalBookings;
  final double startingPrice;
  final String nextAvailable;
  final bool isAvailable;
  final bool isLicensed;
  final bool isBackgroundVerified;
  final bool isCovidVaccinated;
  final List<String> specialties;
  final List<String> portfolioImages;
  final List<ReviewModel> reviews;

  const BarberModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profileImage = '',
    this.title = 'Master Barber',
    this.experience = 0,
    this.location = '',
    this.distance = 0,
    this.rating = 0,
    this.reviewCount = 0,
    this.totalBookings = 0,
    this.startingPrice = 0,
    this.nextAvailable = '',
    this.isAvailable = false,
    this.isLicensed = false,
    this.isBackgroundVerified = false,
    this.isCovidVaccinated = false,
    this.specialties = const [],
    this.portfolioImages = const [],
    this.reviews = const [],
  });

  String get fullName => '$firstName $lastName';

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      title: json['title'] ?? 'Master Barber',
      experience: json['experience'] ?? 0,
      location: json['location'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      totalBookings: json['total_bookings'] ?? 0,
      startingPrice: (json['starting_price'] ?? 0).toDouble(),
      nextAvailable: json['next_available'] ?? '',
      isAvailable: json['is_available'] ?? false,
      isLicensed: json['is_licensed'] ?? false,
      isBackgroundVerified: json['is_background_verified'] ?? false,
      isCovidVaccinated: json['is_covid_vaccinated'] ?? false,
      specialties: List<String>.from(json['specialties'] ?? []),
      portfolioImages: List<String>.from(json['portfolio_images'] ?? []),
      reviews: (json['reviews'] as List? ?? [])
          .map((r) => ReviewModel.fromJson(r))
          .toList(),
    );
  }
}

