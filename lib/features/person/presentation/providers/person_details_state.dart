import '../../domain/entities/person_details.dart';

class PersonDetailsState {
  const PersonDetailsState({
    this.person,
    this.isLoading = false,
    this.errorMessage,
  });

  final PersonDetails? person;
  final bool isLoading;
  final String? errorMessage;

  PersonDetailsState copyWith({
    PersonDetails? person,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PersonDetailsState(
      person: person ?? this.person,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
