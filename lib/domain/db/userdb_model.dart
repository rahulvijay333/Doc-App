class UserDbModel {
  final UserDbModelDetails user;

  UserDbModel({required this.user});

  factory UserDbModel.fromJson(Map<String, dynamic> json) {
    return UserDbModel(user: UserDbModelDetails.fromJson(json['users']));
  }
}

class UserDbModelDetails {
  final String id;

  final String name;

  final String email;

  final String role;

  final String isVerified;

  final String gender;

  final String phone;

  final String isAdminVerified;

  final String token;

  UserDbModelDetails(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.isVerified,
      required this.gender,
      required this.phone,
      required this.isAdminVerified,
      required this.token});

  factory UserDbModelDetails.fromJson(Map<String, dynamic> json) {
    return UserDbModelDetails(
        id: json['_id'],
        name: json['name'],
        email: 'email',
        role: json['role'],
        isVerified: json['isVerified'],
        gender: json['gender'],
        phone: json['phone'],
        isAdminVerified: json['isAdminVerified'],
        token: json['token']);
  }
}
