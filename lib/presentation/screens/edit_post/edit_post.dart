// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/post_models.dart';
import 'package:evogram/presentation/bloc/edit_post_bloc/edit_post_bloc.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/screens/add_post/widgets/textformfieldaddpost.dart';
import 'package:evogram/presentation/screens/widgets/custom_button.dart';
import 'package:evogram/presentation/screens/widgets/snakbars.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:evogram/presentation/screens/widgets/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:photo_manager/photo_manager.dart';

final ValueNotifier<String> pickEditImage = ValueNotifier('');

class EditPostScreen extends StatelessWidget {
  final Postmodel userpost;
  EditPostScreen({super.key, required this.userpost}) {
    description.text = userpost.description;
  }

  final description = TextEditingController();

  final List<AssetEntity> selectedAssetList = [];

  final _formKey = GlobalKey<FormState>();

  late XFile? file;

  @override
  Widget build(BuildContext context) {
    final editpostbloc = context.read<EditPostBloc>();
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<EditPostBloc, EditPostState>(
        listener: (context, state) {
      if (state is EditPostSuccessState) {
        pickEditImage.value = '';
        customSnackbar(context, 'Edited Successfully', green50);
        Navigator.pop(context);
        context
            .read<FetchingUserPostBloc>()
            .add(FetchingUserpostInitialEvent());
      } else if (state is EditPostErrorState) {
        customSnackbar(context, state.error, redlogout);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        appBar: AppBar(
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          elevation: 4,
          shadowColor: Theme.of(context).brightness == Brightness.light
              ? lightgreyauth
              : darkgreymain,
          automaticallyImplyLeading: false,
          title: appbarTitle(title: 'Edit Post'),
          actions: [
            BlocConsumer<EditPostBloc, EditPostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is EditPostLoadingState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 100,
                      child: loadingButton(
                          media: size, onPressed: () {}, color: blue),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      color: blue,
                      minWidth: 100,
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(pickEditImage.value);
                          if (description.text.isNotEmpty) {
                            print('Description $description');
                            print(pickEditImage);
                            editpostbloc.add(EditPostClickEvent(
                                image: pickEditImage.value,
                                imageurl: userpost.image,
                                description: description.text,
                                postid: userpost.id));
                            debugPrint(description.text);
                            debugPrint(userpost.image);
                          } else {}
                        }
                      },
                      child: const Text('Post',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: white,
                              fontSize: 13))),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: pickEditImage,
                  builder: (context, value, child) {
                    return Stack(
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
                            child: pickEditImage.value == ''
                                ? CachedNetworkImage(
                                    placeholder: (context, url) {
                                      return Center(
                                        child: LoadingAnimationWidget
                                            .threeRotatingDots(
                                                color: blue, size: 10),
                                      );
                                    },
                                    imageUrl: userpost.image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(File(pickEditImage.value),
                                    fit: BoxFit.cover)),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? white
                                    : black,
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                                onPressed: () async {
                                  file = await ImagePicker().pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (file != null) {
                                    print(file!.path);
                                    pickEditImage.value = file!.path;
                                  }
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        )
                      ],
                    );
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
    });
  }
}
