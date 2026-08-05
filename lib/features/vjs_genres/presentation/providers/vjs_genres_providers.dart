import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vjs_genres_notifier.dart';
import 'vjs_genres_state.dart';

final vjsGenresNotifierProvider =
    NotifierProvider<VjsGenresNotifier, VjsGenresState>(VjsGenresNotifier.new);
