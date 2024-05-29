import '../../core/constants.dart';
import 'widgets.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: white,
          automaticallyImplyLeading: false,
          title: appbarTitle(title: 'New Post')),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 300,
                decoration: const BoxDecoration(
                  color: lightgreyauth,
                ),
                child: const Center(
                    child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldAddPost(
                    controller: description,
                    hintText: 'Description',
                    keyboard: TextInputType.name),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: white,
                        minWidth: size.width * .4,
                        height: 55,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: blueaccent3),
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                        child: const Text('Clear',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: blueaccent3,
                                fontSize: 17))),
                    MaterialButton(
                        color: blueaccent3,
                        minWidth: size.width * .4,
                        height: 55,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                        child: const Text('Post',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: white,
                                fontSize: 17))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
