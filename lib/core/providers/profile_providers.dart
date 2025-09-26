import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/core/providers/dio_provider.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/data/profile/repositories/profile_repository_impl.dart';
import 'package:e_commerce_app/domain/profile/repositories/profile_repository.dart';
import 'package:e_commerce_app/presentation/profile/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    dioClient: ref.watch(dioClientProvider),
  ),
);

final profileScreenProvider = ChangeNotifierProvider<ProfileProvider>(
  (ref) => ProfileProvider(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);
