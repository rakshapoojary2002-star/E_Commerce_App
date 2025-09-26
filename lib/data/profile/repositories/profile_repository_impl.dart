import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/data/profile/models/user_profile_model.dart';
import 'package:e_commerce_app/domain/profile/entities/user_profile.dart';
import 'package:e_commerce_app/domain/profile/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient dioClient;

  ProfileRepositoryImpl({required this.dioClient});

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('Auth token not found');
      }

      final response = await dioClient.dio.get(
        '/api/v1/auth/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data['data']['user']);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      rethrow;
    }
  }
}
