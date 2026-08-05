import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/lugabox_logo.dart';
import '../providers/discover_event.dart';
import '../providers/discover_providers.dart';
import '../widgets/discover_filter_bar.dart';
import '../widgets/discover_people_row.dart';
import '../widgets/discover_title_row.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/industry_news_card.dart';
import '../widgets/search_beyond_card.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(discoverNotifierProvider.notifier)
          .onEvent(const DiscoverStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoverNotifierProvider);
    final feed = state.feed;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 28, 18, 46),
              child: Row(
                children: [
                  const Expanded(child: LugaBoxLogo(size: 19)),
                  IconButton(
                    onPressed: () => context.push('/search'),
                    icon: const Icon(Icons.search_rounded, size: 31),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.cast_rounded, size: 29),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_rounded, size: 29),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _DiscoverHeaderDelegate(),
          ),
          if (state.isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.red),
              ),
            )
          else if (state.errorMessage != null && feed == null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ),
              ),
            )
          else if (feed != null)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 0, 24),
                    child: DiscoverFilterBar(),
                  ),
                  FeaturedCarousel(items: feed.featured),
                  const IndustryNewsCard(),
                  DiscoverTitleRow(
                    title: 'Trending now',
                    movies: feed.trendingNow,
                  ),
                  DiscoverTitleRow(
                    title: 'Airing today',
                    movies: feed.airingToday,
                  ),
                  DiscoverTitleRow(
                    title: 'Popular movies',
                    movies: feed.popularMovies,
                  ),
                  DiscoverTitleRow(
                    title: 'Popular series',
                    movies: feed.popularSeries,
                  ),
                  DiscoverPeopleRow(
                    title: 'Trending People',
                    people: feed.trendingPeople,
                  ),
                  DiscoverTitleRow(
                    title: 'Top-rated movies',
                    movies: feed.topRatedMovies,
                  ),
                  DiscoverTitleRow(
                    title: 'Top-rated series',
                    movies: feed.topRatedSeries,
                  ),
                  DiscoverPeopleRow(
                    title: 'Popular Stars & Creators',
                    people: feed.popularPeople,
                  ),
                  DiscoverTitleRow(
                    title: 'Coming soon',
                    movies: feed.comingSoon,
                  ),
                  const SearchBeyondCard(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DiscoverHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 78;

  @override
  double get maxExtent => 78;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFF170F0F).withValues(alpha: .94),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: const Text(
        'Discover',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DiscoverHeaderDelegate oldDelegate) => false;
}
