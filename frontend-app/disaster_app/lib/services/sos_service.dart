import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';
import '../services/location_service.dart';

class SosService {
  static Future<void> triggerSOS(List<Contact> contacts) async {
    final position = await LocationService.getCurrentLocation();

    if (position == null) {
      throw Exception("Location not available");
    }

    final String message =
        "🚨 EMERGENCY! I need help.\nMy location:\nhttps://maps.google.com/?q=${position.latitude},${position.longitude}";

    for (var contact in contacts) {
      final Uri smsUri = Uri.parse(
        "sms:${contact.phone}?body=${Uri.encodeComponent(message)}",
      );

      await launchUrl(smsUri, mode: LaunchMode.externalApplication);
    }
  }
}
