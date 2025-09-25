class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? token; // optional now

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      token: token, // assign token passed from outside
    );
  }
}
