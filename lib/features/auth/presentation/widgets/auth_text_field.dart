import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscured,
          validator: widget.validator,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppColors.muted,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => setState(() => _obscured = !_obscured),
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.field,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 17,
            ),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.white),
            errorBorder: _border(AppColors.red),
            focusedErrorBorder: _border(AppColors.red),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
