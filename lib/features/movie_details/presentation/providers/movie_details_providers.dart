import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_details_notifier.dart';
import 'movie_details_state.dart';

final movieDetailsNotifierProvider =
    NotifierProvider<MovieDetailsNotifier, MovieDetailsState>(
      MovieDetailsNotifier.new,
    );
