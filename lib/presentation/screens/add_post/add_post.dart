// ignore_for_file: avoid_print, must_be_immutable

import 'dart:io';

import 'package:evogram/presentation/bloc/add_post_bloc/addpost_bloc.dart';

import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/screens/main_screen/main_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_button.dart';
import 'package:evogram/presentation/screens/widgets/snakbars.dart';
import 'package:evogram/presentation/screens/widgets/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../application/core/constants.dart';
import 'widgets/textformfieldaddpost.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

final ValueNotifier<String> pickImage = ValueNotifier('');

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  final description = TextEditingController();

  final List<AssetEntity> selectedAssetList = [];
  final _formKey = GlobalKey<FormState>();

  late XFile? file;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<AddpostBloc, AddpostState>(
      listener: (context, state) {
        if (state is AddPostSuccesState) {
          context
              .read<FetchingUserPostBloc>()
              .add(FetchingUserpostInitialEvent());
          currentPage.value = 4;
          successSnakbar(context, 'Post added successfully', green50);
          pickImage.value = '';

          description.clear();
        } else if (state is AddPostErrorState) {
          failedSnakbar(context, state.error, redlogout);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? white
              : const Color.fromARGB(255, 15, 15, 15),
          appBar: AppBar(
            surfaceTintColor: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
            elevation: 4,
            shadowColor: Theme.of(context).brightness == Brightness.light
                ? lightgreyauth
                : darkgreymain,
            automaticallyImplyLeading: false,
            title: appbarTitle(title: 'New Post'),
            actions: [
              BlocBuilder<AddpostBloc, AddpostState>(
                builder: (context, state) {
                  if (state is AddPostLoadingstate) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        height: 40,
                        child: loadingButton(
                          media: size,
                          onPressed: () {},
                          color: buttonclr,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: buttonclr,
                        minWidth: 100,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(pickImage.value);
                            if (pickImage.value.isNotEmpty &&
                                description.text.isNotEmpty) {
                              context.read<AddpostBloc>().add(
                                    OnPostButtonClickedEvent(
                                      imagePath: pickImage.value,
                                      description: description.text,
                                    ),
                                  );
                            } else {
                              warningSnakbar(context,
                                  'Select an image and Add Description', red);
                            }
                          }
                        },
                        child: const Text('Post',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: white,
                                fontSize: 13))),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: pickImage,
                    builder: (context, value, child) {
                      return GestureDetector(
                          onTap: () async {
                            file = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            if (file != null) {
                              print(file!.path);
                              pickImage.value = file!.path;
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                  width: size.width,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? bgcolor
                                        : darkgreymain,
                                  ),
                                  child: pickImage.value == ''
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.photo,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? lightgrey
                                                  : darkgrey,
                                              size: 50,
                                            ),
                                            const Text(
                                              'Add Image....',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: grey),
                                            ),
                                            h10,
                                          ],
                                        )
                                      : Image.file(File(pickImage.value),
                                          fit: BoxFit.cover)),
                              pickImage.value.isNotEmpty
                                  ? Positioned(
                                      top: 10,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            pickImage.value = '';
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? red
                                                    : darkgrey,
                                            size: 35,
                                          )),
                                    )
                                  : h10,
                            ],
                          ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormFieldAddPost(
                          validator: validatePostdesctiption,
                          controller: description,
                          hintText: 'Add Description...',
                          keyboard: TextInputType.name),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        logoletters,
                        width: size.width * .4,
                        color: Theme.of(context).brightness == Brightness.light
                            ? bgcolor
                            : darkgrey.withOpacity(.3),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
