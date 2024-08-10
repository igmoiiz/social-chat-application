import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final TextEditingController controller;
  final RegExp validationRegExp;
  var suffixIcon;
  final void Function(String?) onSave;
  MyTextfield({
    super.key,
    required this.labelText,
    required this.obscure,
    required this.controller,
    required this.suffixIcon,
    required this.validationRegExp,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
      child: TextFormField(
        onSaved: onSave,
        validator: (value) {
          if (value != null && validationRegExp.hasMatch(value)) {
            return null;
          }
          return 'Please Enter Your ${labelText.toString()}';
        },
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          suffix: suffixIcon,
          labelText: labelText,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.grey), // Default border color
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .primary), // Border color when focused
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
