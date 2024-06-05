import 'package:flutter/cupertino.dart';


import '../../core/constants.dart';
import 'widgets/textformfieldaddpost.dart';
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
        elevation: 6,
        shadowColor: lightgreyauth,
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'New Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: blueaccent3,
                minWidth: 100,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {},
                child: const Text('Post',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: white,
                        fontSize: 13))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                
                },
                child: Container(
                    width: size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightgreyauth
                          : darkgrey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.photo,
                            color: lightgrey,
                            size: 50,
                          ),
                          Text(
                            'Add Image....',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: grey),
                          ),
                          h10,
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldAddPost(
                    controller: description,
                    hintText: 'Add Description...',
                    keyboard: TextInputType.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
