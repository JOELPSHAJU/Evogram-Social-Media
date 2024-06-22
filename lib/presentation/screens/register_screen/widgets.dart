import '../../../application/core/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldAuthRegister extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  const TextFormFieldAuthRegister(
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
          fillColor: Theme.of(context).brightness == Brightness.light
              ? lightgreyauth
              : darkgreymain,
          filled: true,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? darkbg
                  : grey),
          label: Text(
            hintText,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: lightgrey)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? buttonclr
                      : white)),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: grey))),
    );
  }
}

bool obsecure = true;

class TextFormFieldPasswordRegister extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const TextFormFieldPasswordRegister({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  State<TextFormFieldPasswordRegister> createState() =>
      _TextFormFieldPasswordRegisterState();
}

class _TextFormFieldPasswordRegisterState
    extends State<TextFormFieldPasswordRegister> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 2,
      controller: widget.controller,
      validator: widget.validator,
      cursorColor:
          Theme.of(context).brightness == Brightness.light ? black : white,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          fillColor: Theme.of(context).brightness == Brightness.light
              ? lightgreyauth
              : darkgreymain,
          filled: true,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? darkgrey
                  : white),
          label: Text(
            widget.hintText,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.light
                    ? darkgrey
                    : grey),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: lightgrey)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? buttonclr
                      : white)),
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
