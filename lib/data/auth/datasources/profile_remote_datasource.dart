import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<UserModel> getProfile(String token) async {
    final response = await dio.get(
      "https://tcommmerce.vercel.app/api/v1/auth/profile",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    final userJson = response.data['data']['user'];
    return UserModel.fromJson(userJson);
  }
}
