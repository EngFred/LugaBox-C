import 'package:dio/dio.dart';

import '../../../../core/config/app_env.dart';
import '../../../../core/network/tmdb_exception.dart';
import '../models/person_details_model.dart';

class PersonRemoteDataSource {
  const PersonRemoteDataSource(this._dio);

  final Dio _dio;

  Future<PersonDetailsModel> fetchPerson(int id) async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '/person/$id',
      queryParameters: {
        'append_to_response': 'images,external_ids,combined_credits',
      },
    );

    return PersonDetailsModel.fromJson(response.data ?? {});
  }
}
