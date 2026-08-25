import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.title,
    this.maxLines,
    this.validator,
  });

  final TextEditingController controller;

  final String hintText;
  final String title;
  final int? maxLines;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
