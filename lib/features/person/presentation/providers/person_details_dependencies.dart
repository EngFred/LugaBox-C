import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/person_remote_data_source.dart';
import '../../data/repositories/person_repository_impl.dart';
import '../../domain/repositories/person_repository.dart';
import '../../domain/usecases/get_person_details.dart';

final personRemoteDataSourceProvider = Provider<PersonRemoteDataSource>((ref) {
  return PersonRemoteDataSource(ref.watch(dioProvider));
});

final personRepositoryProvider = Provider<PersonRepository>((ref) {
  return PersonRepositoryImpl(ref.watch(personRemoteDataSourceProvider));
});

final getPersonDetailsProvider = Provider<GetPersonDetails>((ref) {
  return GetPersonDetails(ref.watch(personRepositoryProvider));
});
