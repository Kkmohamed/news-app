import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLines = 1,
    this.suffixIcon,
    required this.obscureText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final int maxLines;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: widget.keyboardType,
          cursorColor: Theme.of(context).primaryColor,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText && !_isVisible,
          controller: widget.controller,
          style: Theme.of(context).textTheme.labelMedium,
          validator:
              widget.validator != null
                  ? (String? value) => widget.validator!(value)
                  : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon:
                          _isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
