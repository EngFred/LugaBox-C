import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/lugabox_logo.dart';
import '../../../home/domain/entities/genre.dart';
import '../providers/vjs_genres_event.dart';
import '../providers/vjs_genres_providers.dart';
import '../widgets/catalog_chip_wrap.dart';

class VjsGenresPage extends ConsumerStatefulWidget {
  const VjsGenresPage({super.key});

  @override
  ConsumerState<VjsGenresPage> createState() => _VjsGenresPageState();
}

class _VjsGenresPageState extends ConsumerState<VjsGenresPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(vjsGenresNotifierProvider.notifier)
          .onEvent(const VjsGenresStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vjsGenresNotifierProvider);

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 28, 18, 58),
              child: Row(
                children: [
                  const Expanded(child: LugaBoxLogo(size: 19)),
                  IconButton(
                    onPressed: () {},
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
          if (state.isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.red),
              ),
            )
          else if (state.errorMessage != null)
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(27, 0, 27, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VJs & Genres',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 21),
                    const Text(
                      'Browse by your favourite VJ or explore a genre.',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 45),
                    const Text(
                      'Popular VJs',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 23),
                    CatalogChipWrap<String>(
                      items: state.vjs,
                      labelFor: (vj) => vj,
                      onSelected: (vj) =>
                          context.push('/vj/${Uri.encodeComponent(vj)}'),
                    ),
                    const SizedBox(height: 53),
                    const Text(
                      'Genres',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 23),
                    CatalogChipWrap<Genre>(
                      items: state.genres,
                      labelFor: (genre) => genre.name,
                      onSelected: (genre) => context.push(
                        '/genre/${genre.id}/${Uri.encodeComponent(genre.name)}',
                      ),
                    ),
                    const SizedBox(height: 38),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
