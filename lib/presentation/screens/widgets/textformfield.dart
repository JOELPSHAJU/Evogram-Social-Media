import '../../../application/core/constants.dart';

import 'package:flutter/material.dart';

const authheadingstyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black);

class TextformfieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const TextformfieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 2,
      controller: controller,
      validator: validator,
      cursorColor:
          Theme.of(context).brightness == Brightness.light ? black : white,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          fillColor: Theme.of(context).brightness == Brightness.light
              ? lightgreyauth
              : darkgreymain,
          filled: true,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: lightgrey)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: blue, width: 1.5)),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: grey))),
    );
  }
}

bool obsecure = true;

class TextFormFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const TextFormFieldPassword({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  State<TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<TextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 2,
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: black,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          fillColor: lightgreyauth,
          filled: true,
          hintText: widget.hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: lightgrey)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: blue)),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: grey)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obsecure = !obsecure;
                });
              },
              icon: obsecure == true
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : const Icon(Icons.visibility, color: Colors.grey))),
      obscureText: obsecure,
    );
  }
}
