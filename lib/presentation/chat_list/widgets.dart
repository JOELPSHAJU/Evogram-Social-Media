import '../../core/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldChatPage extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  const TextFormFieldChatPage(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboard,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorWidth: 2,
      controller: controller,
      keyboardType: keyboard,
      cursorColor:
          Theme.of(context).brightness == Brightness.light ? black : white,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: lightgreyauth)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: lightgreyauth)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: lightgreyauth)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: lightgreyauth)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: lightgreyauth)),
        prefixIcon: const Icon(
          Icons.search,
        ),
        fillColor: Theme.of(context).brightness == Brightness.light
            ? lightgrey
            : darkgreymain,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
