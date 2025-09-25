import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/data/auth/datasources/profile_remote_datasource.dart';
import 'package:e_commerce_app/data/auth/models/user_model.dart';

/// Provide Dio globally
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

/// Provide ProfileRemoteDataSource
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProfileRemoteDataSource(dio);
});

/// Fetch Profile using FutureProvider
final profileProvider = FutureProvider.family<UserModel, String>((
  ref,
  token,
) async {
  final dataSource = ref.watch(profileRemoteDataSourceProvider);
  return dataSource.getProfile(token);
});
