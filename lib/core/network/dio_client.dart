import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import 'auth_interceptor.dart';
import 'secure_storage_service.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(AuthInterceptor(secureStorage));

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});