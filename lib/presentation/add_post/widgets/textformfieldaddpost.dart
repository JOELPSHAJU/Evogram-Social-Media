import '../../../core/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldAddPost extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  const TextFormFieldAddPost(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboard,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        minLines: 3,
        maxLines: 5,
        maxLength: 150,
        validator: validator,
        cursorWidth: 2,
        controller: controller,
        keyboardType: keyboard,
        cursorColor:
            Theme.of(context).brightness == Brightness.light ? black : white,
        style: const TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? grey
                  : white,
            ),
            fillColor: Theme.of(context).brightness == Brightness.light
                ? lightgreyauth
                : darkgrey,
            filled: true,
            hintText: hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: lightgrey)),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            disabledBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            errorBorder:
                const OutlineInputBorder(borderSide: BorderSide.none)));
  }
}
