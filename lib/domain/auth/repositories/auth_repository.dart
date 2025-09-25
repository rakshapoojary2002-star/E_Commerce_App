import 'package:e_commerce_app/data/auth/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  });

  Future<UserModel> login({required String email, required String password});
}
