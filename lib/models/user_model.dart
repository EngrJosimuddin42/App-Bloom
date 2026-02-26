class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? avatar;
  final String token;
  final String role; // 'customer' or 'barber'

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.avatar,
    required this.token,
    required this.role,
  });

  // ── Full name helper ──
  String get fullName => '$firstName $lastName';

  // ── Role helpers ──
  bool get isCustomer => role == 'customer';
  bool get isBarber => role == 'barber';

  // ── JSON থেকে Model ──
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'] ?? json['firstName'] ?? '',
      lastName: json['last_name'] ?? json['lastName'] ?? '',
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      token: json['token'] ?? '',
      role: json['role'] ?? 'customer',
    );
  }

  // ── Model থেকে JSON ──
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'token': token,
      'role': role,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $fullName, email: $email, role: $role)';
  }
}