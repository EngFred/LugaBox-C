import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  const AppEnv._();

  static const _tmdbApiKeyFromDefine = String.fromEnvironment('TMDB_API_KEY');

  static String get tmdbApiKey {
    final fromDefine = _tmdbApiKeyFromDefine.trim();
    if (_isUsableKey(fromDefine)) return fromDefine;

    return (dotenv.env['TMDB_API_KEY'] ?? '').trim();
  }

  static bool get hasTmdbApiKey {
    return _isUsableKey(tmdbApiKey);
  }

  static bool _isUsableKey(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;

    final upper = normalized.toUpperCase();
    return !upper.contains('YOUR_') &&
        !upper.contains('API_KEY_HERE') &&
        !upper.contains('PLACEHOLDER');
  }
}
