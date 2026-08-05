import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/lugabox_logo.dart';
import '../../../../core/session/session_store.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../shell/presentation/pages/main_shell_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routePath = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final isLoggedIn = await SessionStore.isLoggedIn();
      if (!mounted) return;
      context.go(isLoggedIn ? MainShellPage.routePath : LoginPage.routePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LugaBoxLogo(size: 64, centered: true),
            SizedBox(height: 46),
            _LoadingDots(),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  const _LoadingDots();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(),
        SizedBox(width: 14),
        _Dot(),
        SizedBox(width: 14),
        _Dot(),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: 4, backgroundColor: AppColors.red);
  }
}
