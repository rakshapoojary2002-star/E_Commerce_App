import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/flutter_secure.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../../../core/network/dio_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl(this.dioClient);

  @override
  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final data = {
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
        "email": email.trim(),
        "password": password.trim(),
        if (phone != null && phone.trim().isNotEmpty) "phone": phone.trim(),
      };

      debugPrint('Register payload: $data');

      final response = await dioClient.dio.post(
        '/api/v1/auth/register/',
        data: data,
      );

      debugPrint('Raw response data: ${response.data}');

      final userJson = response.data['data']['user'];
      final token = response.data['data']['token'];

      return UserModel.fromJson(userJson, token: token);
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('DioError response data: ${e.response!.data}');
        debugPrint('DioError status code: ${e.response!.statusCode}');
        debugPrint('DioError headers: ${e.response!.headers}');

        try {
          final msg = e.response!.data['message'];
          throw Exception(msg ?? 'Registration failed');
        } catch (_) {
          throw Exception(
            'Registration failed. Status code: ${e.response!.statusCode}',
          );
        }
      } else {
        debugPrint('DioError without response: $e');
        throw Exception('Registration failed. No response from server.');
      }
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post(
        '/api/v1/auth/login',
        data: {"email": email.trim(), "password": password.trim()},
      );

      final userJson = response.data['data']['user'];
      final token = response.data['data']['token'];

      await SecureStorage.saveToken(token);
      print('Token stored: $token');

      return UserModel.fromJson(userJson, token: token);
    } on DioError catch (e) {
      debugPrint('DioError response: ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
