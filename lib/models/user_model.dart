class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? avatar;
  final String token;
  final String role; // 'customer' or 'barber'
  final String? applicationStatus; // 'pending' | 'verified' | 'rejected'

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.avatar,
    required this.token,
    required this.role,
    this.applicationStatus,
  });

  // ── Full name helper ──
  String get fullName => '$firstName $lastName';

  // ── Role helpers ──
  bool get isCustomer => role == 'customer';
  bool get isBarber   => role == 'barber';

  // ── Application Status helpers ──
  bool get isVerified => applicationStatus == 'verified';
  bool get isPending  => applicationStatus == 'pending';
  bool get isRejected => applicationStatus == 'rejected';

  // ── JSON থেকে Model ──
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:                json['id'],
      firstName:         json['first_name'] ?? json['firstName'] ?? '',
      lastName:          json['last_name']  ?? json['lastName']  ?? '',
      email:             json['email'],
      phone:             json['phone'],
      avatar:            json['avatar'],
      token:             json['token'] ?? '',
      role:              json['role']  ?? 'customer',
      applicationStatus: json['application_status'],
    );
  }

  // ── Model থেকে JSON ──
  Map<String, dynamic> toJson() {
    return {
      'id':                 id,
      'first_name':         firstName,
      'last_name':          lastName,
      'email':              email,
      'phone':              phone,
      'avatar':             avatar,
      'token':              token,
      'role':               role,
      'application_status': applicationStatus,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $fullName, email: $email, role: $role, status: $applicationStatus)';
  }
}