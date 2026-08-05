import '../../domain/entities/person_details.dart';
import '../../domain/repositories/person_repository.dart';
import '../datasources/person_remote_data_source.dart';

class PersonRepositoryImpl implements PersonRepository {
  const PersonRepositoryImpl(this._remoteDataSource);

  final PersonRemoteDataSource _remoteDataSource;

  @override
  Future<PersonDetails> getPerson(int id) {
    return _remoteDataSource.fetchPerson(id);
  }
}
