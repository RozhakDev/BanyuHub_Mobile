import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:8000';

  static String get apiUrl => '$baseUrl/api';

  static const String tokenKey = 'access_token';
}