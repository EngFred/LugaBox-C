import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_feed_notifier.dart';
import 'home_feed_state.dart';

final homeFeedNotifierProvider =
    NotifierProvider<HomeFeedNotifier, HomeFeedState>(HomeFeedNotifier.new);
