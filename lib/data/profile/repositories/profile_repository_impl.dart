import 'package:e_commerce_app/domain/profile/entities/profile_entity.dart';
import 'package:e_commerce_app/domain/profile/repositories/profile_repository.dart';

import '../../../core/network/dio_client.dart';

import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient dioClient;

  ProfileRepositoryImpl(this.dioClient);

  @override
  Future<ProfileEntity> getProfile(String token) async {
    final response = await dioClient.dio.get(
      '/api/v1/auth/me',
      options: dioClient.getAuthOptions(token),
    );
    return ProfileModel.fromJson(response.data['data']['user']);
  }
}
