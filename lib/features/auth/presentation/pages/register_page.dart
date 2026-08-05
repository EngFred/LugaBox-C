import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/session/session_store.dart';
import '../../../shell/presentation/pages/main_shell_page.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_auth_button.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routePath = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(31, 27, 31, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthBackButton(
                  onPressed: () => context.go(LoginPage.routePath),
                ),
                const SizedBox(height: 55),
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Start watching movies and series on LugaBox.',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 78),
                AuthTextField(
                  controller: _nameController,
                  label: 'Name',
                  hint: 'Enter your name',
                  validator: _required,
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final text = (value ?? '').trim();
                    if (!text.contains('@') || !text.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter password',
                  obscureText: true,
                  validator: (value) {
                    if ((value ?? '').trim().length < 4) {
                      return 'Enter at least 4 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                AuthPrimaryButton(label: 'Create account', onPressed: _submit),
                const SizedBox(height: 34),
                SocialAuthButton(onPressed: _completeLogin),
                const SizedBox(height: 30),
                Center(
                  child: TextButton(
                    onPressed: () => context.go(LoginPage.routePath),
                    child: const Text(
                      'Already have an account? Sign in',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if ((value ?? '').trim().isEmpty) return 'This field is required';
    return null;
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _completeLogin();
    }
  }

  Future<void> _completeLogin() async {
    await SessionStore.markLoggedIn();
    if (mounted) context.go(MainShellPage.routePath);
  }
}
