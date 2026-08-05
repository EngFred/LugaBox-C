import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'title_listing_notifier.dart';
import 'title_listing_state.dart';

final titleListingNotifierProvider =
    NotifierProvider<TitleListingNotifier, TitleListingState>(
      TitleListingNotifier.new,
    );
