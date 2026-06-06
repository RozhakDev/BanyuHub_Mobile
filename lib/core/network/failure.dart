import 'package:dio/dio.dart';

class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});

  factory Failure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure(message: 'Koneksi ke server terputus (Timeout).');
      case DioExceptionType.badResponse:
        return Failure._handleResponseError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.connectionError:
        return Failure(message: 'Tidak ada koneksi internet.');
      default:
        return Failure(message: 'Terjadi kesalahan yang tidak terduga.');
    }
  }

  factory Failure._handleResponseError(int? statusCode, dynamic data) {
    String message = 'Terjadi kesalahan pada server.';
    
    if (data != null && data is Map<String, dynamic>) {
      if (data.containsKey('message')) {
        message = data['message'];
      } else if (data.containsKey('error')) {
        message = data['error'];
      }
    }

    switch (statusCode) {
      case 400:
        return Failure(message: message, statusCode: statusCode);
      case 401:
        return Failure(message: 'Sesi Anda telah berakhir. Silakan login kembali.', statusCode: statusCode);
      case 403:
        return Failure(message: 'Anda tidak memiliki akses.', statusCode: statusCode);
      case 404:
        return Failure(message: 'Data tidak ditemukan.', statusCode: statusCode);
      case 500:
        return Failure(message: 'Internal Server Error.', statusCode: statusCode);
      default:
        return Failure(message: message, statusCode: statusCode);
    }
  }

  @override
  String toString() => message;
}