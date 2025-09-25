import 'package:e_commerce_app/domain/profile/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
  }) : super(
         id: id,
         firstName: firstName,
         lastName: lastName,
         email: email,
         phone: phone,
       );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}
