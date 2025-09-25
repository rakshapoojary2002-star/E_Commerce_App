import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/data/auth/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/domain/auth/repositories/auth_repository.dart';
import 'dio_provider.dart';

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRepositoryImpl(dioClient);
});

// Login State
final loginProvider = FutureProvider.family.autoDispose((
  ref,
  Map<String, String> data,
) async {
  final repo = ref.watch(authRepositoryProvider);
  return await repo.login(email: data['email']!, password: data['password']!);
});

// Register State
final registerProvider = FutureProvider.family.autoDispose((
  ref,
  Map<String, String> data,
) async {
  final repo = ref.watch(authRepositoryProvider);
  return await repo.register(
    firstName: data['firstName']!,
    lastName: data['lastName']!,
    email: data['email']!,
    password: data['password']!,
  );
});
