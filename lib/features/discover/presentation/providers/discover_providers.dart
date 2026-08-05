import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'discover_notifier.dart';
import 'discover_state.dart';

final discoverNotifierProvider =
    NotifierProvider<DiscoverNotifier, DiscoverState>(DiscoverNotifier.new);
