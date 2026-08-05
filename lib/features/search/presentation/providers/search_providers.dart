import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_notifier.dart';
import 'search_state.dart';

final searchNotifierProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
