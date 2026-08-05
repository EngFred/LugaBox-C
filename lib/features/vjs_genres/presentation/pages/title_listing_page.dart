import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/title_listing_event.dart';
import '../providers/title_listing_providers.dart';
import '../providers/title_listing_state.dart';
import '../widgets/title_grid_card.dart';

class TitleListingPage extends ConsumerStatefulWidget {
  const TitleListingPage({super.key, required this.args});

  final TitleListingArgs args;

  @override
  ConsumerState<TitleListingPage> createState() => _TitleListingPageState();
}

class _TitleListingPageState extends ConsumerState<TitleListingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(titleListingNotifierProvider.notifier)
          .onEvent(TitleListingStarted(widget.args));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(titleListingNotifierProvider);
    final notifier = ref.read(titleListingNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (metrics.pixels > metrics.maxScrollExtent - 700) {
              notifier.onEvent(const TitleListingNextPageRequested());
            }
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 17, 20, 15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF151515)),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: context.pop,
                        icon: const Icon(Icons.arrow_back, size: 31),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.args.title.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${state.movies.length}+ titles',
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.red),
                  ),
                )
              else if (state.errorMessage != null && !state.hasMovies)
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
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
                  sliver: SliverGrid.builder(
                    itemCount: state.movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 14,
                          childAspectRatio: .47,
                        ),
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return TitleGridCard(
                        movie: movie,
                        onTap: () => context.push(
                          '/details/${movie.mediaType}/${movie.id}',
                        ),
                      );
                    },
                  ),
                ),
                if (state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.red),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
