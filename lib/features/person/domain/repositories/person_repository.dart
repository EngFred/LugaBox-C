import '../entities/person_details.dart';

abstract class PersonRepository {
  Future<PersonDetails> getPerson(int id);
}
