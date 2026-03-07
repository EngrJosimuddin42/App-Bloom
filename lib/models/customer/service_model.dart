class ServiceModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final String icon;
  final bool isPopular;

  const ServiceModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.durationMinutes,
    this.icon = '',
    this.isPopular = false,
  });

  String get durationLabel {
    if (durationMinutes >= 60) {
      final h = durationMinutes ~/ 60;
      final m = durationMinutes % 60;
      return m == 0 ? '${h}h' : '${h}h ${m}min';
    }
    return '${durationMinutes}min';
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      durationMinutes: json['duration_minutes'] ?? 30,
      icon: json['icon'] ?? '',
      isPopular: json['is_popular'] ?? false,
    );
  }
}