import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  const AppEnv._();

  static String get tmdbApiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static bool get hasTmdbApiKey {
    final value = tmdbApiKey.trim();
    return value.isNotEmpty && value != '91897819e9458ab5227fcaa49ecbf835';
  }
}
