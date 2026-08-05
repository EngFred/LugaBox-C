import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/movie_details/presentation/pages/movie_details_page.dart';
import '../../features/movie_details/presentation/pages/trailer_player_page.dart';
import '../../features/person/presentation/pages/person_details_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashPage.routePath,
    routes: [
      GoRoute(
        path: SplashPage.routePath,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.routePath,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: MainShellPage.routePath,
        builder: (context, state) => const MainShellPage(),
      ),
      GoRoute(
        path: '/details/:mediaType/:id',
        builder: (context, state) {
          return MovieDetailsPage(
            mediaType: state.pathParameters['mediaType'] ?? 'movie',
            id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
          );
        },
      ),
      GoRoute(
        path: '/trailer/:title/:key',
        builder: (context, state) {
          return TrailerPlayerPage(
            title: Uri.decodeComponent(state.pathParameters['title'] ?? ''),
            youtubeKey: state.pathParameters['key'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/person/:id',
        builder: (context, state) {
          return PersonDetailsPage(
            id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
          );
        },
      ),
    ],
  );
});
