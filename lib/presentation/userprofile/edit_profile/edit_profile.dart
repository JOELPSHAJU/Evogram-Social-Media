// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:evogram/application/models/login_user.dart';
import 'package:evogram/infrastructure/bloc/add_post_bloc/addpost_bloc.dart';
import 'package:evogram/infrastructure/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:evogram/presentation/add_post/add_post.dart';
import 'package:evogram/presentation/widgets/custom_button.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants.dart';
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
  late XFile? Coverpicfile;
  late XFile? profilepicfile;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: appbarTitle(title: 'Edit Profile'),
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
                    return GestureDetector(
                      onTap: () async {
                        Coverpicfile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (Coverpicfile != null) {
                          coverimageeditprofile.value = Coverpicfile!.path;
                        }
                        print(coverimageeditprofile.value);
                      },
                      child: Container(
                        width: size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            color: blueaccent,
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
                                left: size.width * .1,
                                bottom: -80,
                                child: ValueListenableBuilder(
                                    valueListenable: profileimageeditprofile,
                                    builder: (context, value, child) {
                                      return GestureDetector(
                                        onTap: () async {
                                          profilepicfile =
                                              await ImagePicker().pickImage(
                                            source: ImageSource.gallery,
                                          );
                                          if (profilepicfile != null) {
                                            profileimageeditprofile.value =
                                                profilepicfile!.path;
                                          }
                                          print(profileimageeditprofile.value);
                                        },
                                        child: Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
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
                                              color: blueaccent3,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 5,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? white
                                                      : black)),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              EditButton(),
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                          ],
                        ),
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
                          controller: bioController,
                          hintText: 'Add a bio....',
                          keyboard: TextInputType.text,
                          minlines: 3,
                          maxlines: 5),
                    ),
                  ],
                ),
              ),
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
                        color: blue,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20),
                  child: MaterialButton(
                      color: blue,
                      minWidth: size.width,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        if (_editprofileformkey.currentState!.validate()) {
                          if (bioController.text.isNotEmpty &&
                              nameController.text.isNotEmpty) {
                        

                            context.read<EditProfileBloc>().add(
                                EditprofileClickEvent(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    image: profileimageeditprofile.value,
                                    imageurl: profilepic,
                                    backgroundImage:
                                        coverimageeditprofile.value,
                                    backgroundImageurl: coverpic));
                          } else {
                            customSnackbar(context, 'Fill all the fields', red);
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
        ),
      ),
    );
  }
}
