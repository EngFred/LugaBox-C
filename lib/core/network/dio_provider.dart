import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_env.dart';
import 'api_constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.tmdbBaseUrl,
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      queryParameters: {if (AppEnv.hasTmdbApiKey) 'api_key': AppEnv.tmdbApiKey},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (AppEnv.hasTmdbApiKey &&
            !options.queryParameters.containsKey('api_key')) {
          options.queryParameters['api_key'] = AppEnv.tmdbApiKey;
        }
        handler.next(options);
      },
    ),
  );

  return dio;
});
