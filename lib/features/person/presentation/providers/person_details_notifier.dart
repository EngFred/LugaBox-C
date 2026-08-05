import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_person_details.dart';
import 'person_details_dependencies.dart';
import 'person_details_event.dart';
import 'person_details_state.dart';

class PersonDetailsNotifier extends Notifier<PersonDetailsState> {
  late final GetPersonDetails _getPersonDetails;

  @override
  PersonDetailsState build() {
    _getPersonDetails = ref.watch(getPersonDetailsProvider);
    return const PersonDetailsState();
  }

  Future<void> onEvent(PersonDetailsEvent event) {
    return switch (event) {
      PersonDetailsStarted(:final id) => _load(id),
    };
  }

  Future<void> _load(int id) async {
    state = const PersonDetailsState(isLoading: true);

    try {
      final person = await _getPersonDetails(id);
      state = state.copyWith(
        person: person,
        isLoading: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }
}
