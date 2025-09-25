import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://tcommmerce.vercel.app',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Dio get dio => _dio;

  /// ✅ Add this helper for authorized requests
  Options getAuthOptions(String token) {
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }
}
