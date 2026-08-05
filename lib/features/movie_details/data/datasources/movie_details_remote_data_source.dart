import 'package:dio/dio.dart';

import '../../../../core/config/app_env.dart';
import '../../../../core/network/tmdb_exception.dart';
import '../models/movie_details_model.dart';

class MovieDetailsRemoteDataSource {
  const MovieDetailsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<MovieDetailsModel> fetchDetails({
    required String mediaType,
    required int id,
  }) async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    if (mediaType != 'movie' && mediaType != 'tv') {
      throw TmdbException('Unsupported TMDB media type: $mediaType.');
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '/$mediaType/$id',
      queryParameters: {
        'append_to_response': 'credits,videos,recommendations,similar,keywords',
      },
    );

    return MovieDetailsModel.fromJson(response.data ?? {}, mediaType);
  }
}
