import 'package:url_launcher/url_launcher.dart';

Future<void> launchPrivacyPolicy() async {
  final Uri url = Uri.parse(
      'https://www.freeprivacypolicy.com/live/23a6eb84-0360-4ce5-8580-53a24494b3dc');

  try {
    await launchUrl(url);
  } catch (e) {
    print('Error launching email: $e');
  }
}

Future<void> launchTerms() async {
  final Uri url = Uri.parse(
      'https://www.freeprivacypolicy.com/live/cfe121cc-25c9-4882-a467-0f9bb8ab28da');

  try {
    await launchUrl(url);
  } catch (e) {
    print('Error launching email: $e');
  }
}
