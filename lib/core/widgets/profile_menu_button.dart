import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../session/session_store.dart';
import '../theme/app_colors.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showProfileSheet(context),
      icon: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.field,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.red, width: 1.5),
        ),
        child: const Icon(
          Icons.person_rounded,
          size: 22,
          color: AppColors.muted,
        ),
      ),
    );
  }

  void _showProfileSheet(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Profile menu',
      barrierColor: Colors.black.withValues(alpha: .56),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, _, _) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, _, _) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return Align(
          alignment: Alignment.centerLeft,
          child: FractionalTranslation(
            translation: Offset(-1 + curved.value, 0),
            child: const _ProfileSheet(),
          ),
        );
      },
    );
  }
}

class _ProfileSheet extends StatelessWidget {
  const _ProfileSheet();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        right: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width * .80,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 22, 28, 22),
          decoration: const BoxDecoration(color: AppColors.black),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.more_vert_rounded, size: 26),
                    color: AppColors.muted,
                  ),
                ),
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    color: AppColors.field,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.red, width: 2.5),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 58,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Engineer Fred',
                  style: TextStyle(
                    color: Color(0xFFFFB300),
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'test@gmail.com',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 34),
                const _ProfileMenuTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                ),
                const _ProfileMenuTile(
                  icon: Icons.download_for_offline_outlined,
                  label: 'Downloads',
                ),
                const _ProfileMenuTile(
                  icon: Icons.history_rounded,
                  label: 'My Activity',
                ),
                const _ProfileMenuTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                ),
                const Divider(color: Color(0xFF191919), height: 24),
                const _ProfileMenuTile(
                  icon: Icons.report_problem_outlined,
                  label: 'Report an Issue',
                  accent: Color(0xFFFFD12D),
                ),
                const _ProfileMenuTile(
                  icon: Icons.add_to_queue_outlined,
                  label: 'Request a Movie',
                  accent: Color(0xFF4A7DFF),
                ),
                const Divider(color: Color(0xFF191919), height: 30),
                _ProfileMenuTile(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  accent: AppColors.red,
                  textColor: AppColors.red,
                  onTap: () => _confirmLogout(context),
                ),
                const SizedBox(height: 56),
                const Text(
                  'LugaBox',
                  style: TextStyle(
                    color: Color(0xFF242424),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'v2.0.0',
                  style: TextStyle(
                    color: Color(0xFF242424),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.red),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;
    await SessionStore.logout();
    if (!context.mounted) return;
    Navigator.of(context).pop();
    context.go('/login');
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    this.accent = AppColors.white,
    this.textColor = AppColors.white,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color accent;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 25),
            const SizedBox(width: 22),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: textColor.withValues(alpha: .25),
            ),
          ],
        ),
      ),
    );
  }
}
