import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});
