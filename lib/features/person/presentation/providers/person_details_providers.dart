import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'person_details_notifier.dart';
import 'person_details_state.dart';

final personDetailsNotifierProvider =
    NotifierProvider<PersonDetailsNotifier, PersonDetailsState>(
      PersonDetailsNotifier.new,
    );
