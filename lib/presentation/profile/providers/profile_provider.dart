import 'package:e_commerce_app/data/profile/repositories/profile_repository_impl.dart';
import 'package:e_commerce_app/domain/profile/entities/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepositoryImpl(DioClient()),
);

final profileProvider = FutureProvider.family<ProfileEntity, String>((
  ref,
  token,
) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(token);
});
