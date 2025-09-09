import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLines,
    this.suffixIcon,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          validator:
              validator != null ? (String? value) => validator!(value) : null,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
