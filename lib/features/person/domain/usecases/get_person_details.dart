import '../entities/person_details.dart';
import '../repositories/person_repository.dart';

class GetPersonDetails {
  const GetPersonDetails(this._repository);

  final PersonRepository _repository;

  Future<PersonDetails> call(int id) => _repository.getPerson(id);
}
