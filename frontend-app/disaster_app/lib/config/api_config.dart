import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      // Browser cannot use localhost → use 127.0.0.1
      return "http://127.0.0.1:8080/api";
    } else {
      // Mobile / emulator
      return "http://localhost:8080/api";
    }
  }
}
