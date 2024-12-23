import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvPlugin {
  DotenvPlugin._();

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  //ANDROID
  static String androidApiKey =
      dotenv.env['ANDROID_API_KEY'] ?? 'apiKey-not-found';
  static String androidAppId =
      dotenv.env['ANDROID_APP_ID'] ?? 'appId-not-found';
  static String androidMessagingSenderId =
      dotenv.env['ANDROID_MESSAGING_SENDER_ID'] ??
          'messagingSenderId-not-found';
  static String androidProjectId =
      dotenv.env['ANDROID_PROJECT_ID'] ?? 'projectId-not-found';
  static String androidStorageBucket =
      dotenv.env['ANDROID_STORAGE_BUCKET'] ?? 'storageBucket-not-found';

  //IOS
  static String iosApiKey = dotenv.env['IOS_APP_KEY'] ?? 'apiKey-not-found';
  static String iosAppId = dotenv.env['IOS_APP_ID'] ?? 'appId-not-found';
  static String iosMessagingSenderId =
      dotenv.env['IOS_MESSAGING_SENDER_ID'] ?? 'messagingSenderId-not-found';
  static String iosProjectId =
      dotenv.env['IOS_PROJECT_ID'] ?? 'projectId-not-found';
  static String iosStorageBucket =
      dotenv.env['IOS_STORAGE_BUCKET'] ?? 'storageBucket-not-found';
  static String iosBundleId =
      dotenv.env['IOS_BUNDLE_ID'] ?? 'iosBundleId-not-found';
}
