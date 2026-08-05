import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/lugabox_top_bar.dart';
import '../providers/home_feed_event.dart';
import '../providers/home_feed_providers.dart';
import '../widgets/home_error_view.dart';
import '../widgets/home_loading_view.dart';
import '../widgets/movie_section_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(homeFeedNotifierProvider.notifier)
          .onEvent(const HomeFeedStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeFeedNotifierProvider);
    final notifier = ref.read(homeFeedNotifierProvider.notifier);

    return Column(
      children: [
        const LugaBoxTopBar(),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.red,
            backgroundColor: AppColors.surface,
            onRefresh: () => notifier.onEvent(const HomeFeedRefreshRequested()),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                if (state.isLoading)
                  const HomeLoadingView()
                else if (state.errorMessage != null && !state.hasContent)
                  HomeErrorView(
                    message: state.errorMessage!,
                    onRetry: () => notifier.onEvent(const HomeFeedStarted()),
                  )
                else
                  for (final section in state.sections)
                    MovieSectionList(
                      section: section,
                      showGenreFilters: section.title == 'Browse by Genres',
                      genres: state.genres,
                      onLoadMore: () {
                        notifier.onEvent(
                          HomeFeedSectionPageRequested(section.config.key),
                        );
                      },
                      onGenreSelected: (genre) {
                        context.push(
                          '/genre/${genre.id}/${Uri.encodeComponent(genre.name)}',
                        );
                      },
                    ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
