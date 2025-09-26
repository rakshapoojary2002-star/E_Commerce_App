import 'package:e_commerce_app/domain/profile/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
}
