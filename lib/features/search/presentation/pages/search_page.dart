import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../vjs_genres/presentation/widgets/title_grid_card.dart';
import '../providers/search_event.dart';
import '../providers/search_providers.dart';
import '../widgets/search_filter_tabs.dart';
import '../widgets/search_suggestion_chip.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  static const _popularSearches = [
    'wings of dread',
    'upside-down magic',
    'from',
    'twilight',
    'prison break',
    'money heist',
    'the village',
    'ironheart',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (metrics.pixels > metrics.maxScrollExtent - 700) {
              notifier.onEvent(const SearchNextPageRequested());
            }
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 17, 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: context.pop,
                        icon: const Icon(Icons.arrow_back, size: 28),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onChanged: (value) =>
                              notifier.onEvent(SearchQueryChanged(value)),
                          onSubmitted: (value) =>
                              notifier.onEvent(SearchSubmitted(value)),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search LugaBox',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.red,
                            ),
                            suffixIcon: state.hasQuery
                                ? IconButton(
                                    onPressed: () {
                                      _controller.clear();
                                      notifier.onEvent(const SearchCleared());
                                    },
                                    icon: const Icon(Icons.close_rounded),
                                  )
                                : null,
                            filled: true,
                            fillColor: AppColors.surface,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!state.hasQuery)
                SliverToBoxAdapter(child: _Suggestions(controller: _controller))
              else
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                    child: SearchFilterTabs(
                      selected: state.filter,
                      onChanged: (filter) =>
                          notifier.onEvent(SearchFilterChanged(filter)),
                    ),
                  ),
                ),
              if (state.hasQuery)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 23),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Results for “${state.query}”',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A0508),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '${state.results.length}',
                            style: const TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.w900,
                            ),
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
              else if (state.errorMessage != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ),
                )
              else if (state.hasQuery)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                  sliver: SliverGrid.builder(
                    itemCount: state.results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 14,
                          childAspectRatio: .47,
                        ),
                    itemBuilder: (context, index) {
                      final movie = state.results[index];
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
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.red),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Suggestions extends ConsumerWidget {
  const _Suggestions({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 24, 23, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.red,
                size: 24,
              ),
              SizedBox(width: 13),
              Text(
                'Popular searches',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 11,
            runSpacing: 14,
            children: [
              for (final query in _SearchPageState._popularSearches)
                SearchSuggestionChip(
                  label: query,
                  onTap: () {
                    controller.text = query;
                    notifier.onEvent(SearchSubmitted(query));
                  },
                ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              const Icon(
                Icons.history_rounded,
                color: AppColors.muted,
                size: 24,
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Text(
                  'Recent searches',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              TextButton(
                onPressed: () =>
                    notifier.onEvent(const RecentSearchesCleared()),
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          for (final query in state.recentSearches)
            GestureDetector(
              onTap: () {
                controller.text = query;
                notifier.onEvent(SearchSubmitted(query));
              },
              child: Container(
                height: 58,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.history_rounded, color: AppColors.muted),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        query,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.north_west_rounded,
                      color: AppColors.muted,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
