// ignore_for_file: unnecessary_constructor_name

import 'package:evogram/core/constants.dart';
import 'package:evogram/domain/models/post_models.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/edit_post/edit_post.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupmenuButtons extends StatelessWidget {
  const PopupmenuButtons({super.key, required this.list, required this.index});

  final List<Postmodel> list;
  final int index;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shadowColor: grey,
      elevation: 3,
      popUpAnimationStyle: AnimationStyle(
        curve: const FlippedCurve.new(Curves.easeInOut),
      ),
      color: Theme.of(context).brightness == Brightness.light ? white : black,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(
                Icons.edit,
              ),
              w10,
              Text(
                'Edit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: red,
              ),
              w10,
              Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          navigatePushAnimaterbottomtotop(
              context,
              EditPostScreen(
                userpost: list[index],
              ));
        } else if (value == 'delete') {
          showCustomAlertDialog(context: context, list: list, index: index);
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}

void showCustomAlertDialog(
    {required BuildContext context,
    required List<Postmodel> list,
    required int index}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? white
            : darkgreymain,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              deletebg,
              width: 50,
            ),
            w10,
            const Expanded(
              child: Text(
                "Are you sure you want to delete this post?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          textAlign: TextAlign.center,
          "This will delete this post permanently. You cannot undo this action.",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? darkgrey
                  : grey),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? darkgrey
                            : grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? darkgrey
                          : grey),
                ),
              ),
              MaterialButton(
                color: red,
                onPressed: () {
                  context
                      .read<FetchingUserPostBloc>()
                      .add(DeletePostClickEvent(postId: list[index].id));
                  context
                      .read<FetchingUserPostBloc>()
                      .add(FetchingUserpostInitialEvent());
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(fontWeight: FontWeight.bold, color: white),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
