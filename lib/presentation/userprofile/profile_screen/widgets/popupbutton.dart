import 'package:evogram/domain/models/post_models.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
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
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      onSelected: (value) {
        // Handle the selected option here
        if (value == 'edit') {
        } else if (value == 'delete') {
          context
              .read<FetchingUserPostBloc>()
              .add(DeletePostClickEvent(postId: list[index].id));
          context
              .read<FetchingUserPostBloc>()
              .add(FetchingUserpostInitialEvent());
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
