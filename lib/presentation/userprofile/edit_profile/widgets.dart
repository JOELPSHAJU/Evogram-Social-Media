import '../../../core/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldEditProfile extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int minlines;
  final int maxlines;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  const TextFormFieldEditProfile(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboard,
      this.validator,
      required this.minlines,
      required this.maxlines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorWidth: 2,
      minLines: minlines,
      maxLines: maxlines,
      controller: controller,
      keyboardType: keyboard,
      cursorColor:
          Theme.of(context).brightness == Brightness.light ? black : white,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          fillColor: Theme.of(context).brightness == Brightness.light
              ? lightgreyauth
              : black,
          filled: true,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: lightgrey)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? lightgrey
              : darkgreymain,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              width: 3,
              color: Theme.of(context).brightness == Brightness.light
                  ? white
                  : black)),
      height: 50,
      width: 50,
      child: Center(
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
            )),
      ),
    );
  }
}
