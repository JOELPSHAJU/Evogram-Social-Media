// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:evogram/domain/models/login_user.dart';

import 'package:evogram/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:evogram/presentation/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/gridshimmer.dart';

import 'package:evogram/presentation/screens/widgets/custom_button.dart';
import 'package:evogram/presentation/screens/widgets/snakbars.dart';
import 'package:flutter/foundation.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../application/core/constants.dart';
import 'widgets.dart';
import '../../widgets/text_styles.dart';
import 'package:flutter/material.dart';

final ValueNotifier<String> profileimageeditprofile = ValueNotifier('');
final ValueNotifier<String> coverimageeditprofile = ValueNotifier('');

class EditProfileScreen extends StatelessWidget {
  final LoginUserModel loginuser;
  EditProfileScreen({super.key, required this.loginuser}) {
    nameController.text = loginuser.name.toString();
    bioController.text = loginuser.bio == null ? '' : loginuser.bio.toString();
    coverpic = loginuser.backGroundImage;
    profilepic = loginuser.profilePic;
  }
  final _editprofileformkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  String coverpic = '';
  String profilepic = '';
  XFile? Coverpicfile;
  XFile? profilepicfile;
  @override
  Widget build(BuildContext context) {
    final profileEditBloc = context.read<EditProfileBloc>();
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccessState) {
          context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
          successSnakbar(
              context, 'Profile has been updated\nsuccessfully', grey300);

          FocusScope.of(context).unfocus;
          Navigator.of(context).pop();
        } else if (state is EditProfileErrorState) {
          failedSnakbar(context, 'something went wrong', grey300);
        } else if (state is EditProfileErrorState) {
          failedSnakbar(
              context, 'something went wrong try after sometime', grey300);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
            surfaceTintColor: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
            title: appbarTitle(title: 'Edit Profile'),
            actions: [
              BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                if (state is EditProfileLoadingState) {
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
                  padding: const EdgeInsets.all(8),
                  child: MaterialButton(
                      color: buttonclr,
                      minWidth: 100,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        if (_editprofileformkey.currentState!.validate()) {
                          if (bioController.text.isNotEmpty &&
                              nameController.text.isNotEmpty) {
                            profileEditBloc.add(EditprofileClickEvent(
                                name: nameController.text,
                                bio: bioController.text,
                                image: profilepicfile ?? profilepic,
                                imageUrl:
                                    profilepicfile == null ? profilepic : '',
                                bgImage: Coverpicfile ?? coverpic,
                                bgImageUrl:
                                    Coverpicfile == null ? coverpic : ''));
                          } else {
                            warningSnakbar(
                                context, 'Fill all the fields', grey300);
                          }
                        }
                      },
                      child: const Text('Update',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: white,
                              fontSize: 17))),
                );
              })
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: coverimageeditprofile,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return Container(
                          width: size.width,
                          height: 250,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color.fromARGB(255, 204, 208, 211)
                                      : Color.fromARGB(255, 22, 21, 21),
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(255, 144, 150, 144)
                                      : Color.fromARGB(255, 36, 36, 36),
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color.fromARGB(255, 204, 208, 211)
                                      : Color.fromARGB(255, 24, 23, 23),
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(255, 144, 150, 144)
                                      : Color.fromARGB(255, 29, 28, 28),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              image: DecorationImage(
                                  image: coverimageeditprofile.value.isEmpty
                                      ? NetworkImage(coverpic)
                                      : FileImage(
                                          File(coverimageeditprofile.value),
                                        ),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: GestureDetector(
                                      onTap: () async {
                                        Coverpicfile =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (Coverpicfile != null) {
                                          coverimageeditprofile.value =
                                              Coverpicfile!.path;
                                        }
                                        if (kDebugMode) {
                                          print(coverimageeditprofile.value);
                                        }
                                      },
                                      child: const EditButton())),
                              Positioned(
                                  left: size.width * .1,
                                  bottom: -80,
                                  child: ValueListenableBuilder(
                                      valueListenable: profileimageeditprofile,
                                      builder: (context, value, child) {
                                        return Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Color.fromARGB(
                                                          255, 204, 208, 211)
                                                      : Color.fromARGB(
                                                          255, 22, 21, 21),
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 144, 150, 144)
                                                      : Color.fromARGB(
                                                          255, 36, 36, 36),
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Color.fromARGB(
                                                          255, 204, 208, 211)
                                                      : Color.fromARGB(
                                                          255, 24, 23, 23),
                                                  Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 144, 150, 144)
                                                      : Color.fromARGB(
                                                          255, 29, 28, 28),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              image: DecorationImage(
                                                  image: profileimageeditprofile
                                                          .value.isEmpty
                                                      ? NetworkImage(profilepic)
                                                      : FileImage(
                                                          File(
                                                              profileimageeditprofile
                                                                  .value),
                                                        ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 5,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? white
                                                      : black)),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 20,
                                                right: 20,
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      profilepicfile =
                                                          await ImagePicker()
                                                              .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );
                                                      if (profilepicfile !=
                                                          null) {
                                                        profileimageeditprofile
                                                                .value =
                                                            profilepicfile!
                                                                .path;
                                                      }
                                                      if (kDebugMode) {
                                                        print(
                                                            profileimageeditprofile
                                                                .value);
                                                      }
                                                    },
                                                    child: const EditButton()),
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    width: size.width,
                    height: 80,
                  ),
                  h10,
                  Form(
                    key: _editprofileformkey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextFormFieldEditProfile(
                              maxlen: false,
                              controller: nameController,
                              hintText: 'Name',
                              keyboard: TextInputType.name,
                              minlines: 1,
                              maxlines: 1),
                        ),
                        h20,
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Bio',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8,
                          ),
                          child: TextFormFieldEditProfile(
                              maxlen: true,
                              controller: bioController,
                              hintText: 'Add a bio....',
                              keyboard: TextInputType.text,
                              minlines: 3,
                              maxlines: 5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
