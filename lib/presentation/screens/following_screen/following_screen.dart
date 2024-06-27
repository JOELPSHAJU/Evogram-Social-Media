import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/follow_unfollow_user_bloc/follow_unfollow_user_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/core/constants.dart';
import '../widgets/text_styles.dart';

class FollowingPersonScreen extends StatefulWidget {
  final List<Following> following;
  final FollowingModel model;
  const FollowingPersonScreen(
      {super.key, required this.following, required this.model});

  @override
  State<FollowingPersonScreen> createState() => _FollowingPersonScreenState();
}

class _FollowingPersonScreenState extends State<FollowingPersonScreen> {
  final profilepic =
      'https://www.mensjournal.com/.image/t_share/MTk2MTM2NDk0NzM0MjU1MjQ5/jason-statham-main.jpg';

  final searchPersonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: grey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Following'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: widget.following.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(widget
                                  .following[index].profilePic
                                  .toString()),
                              fit: BoxFit.cover)),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        final user = UserIdSearchModel(
                         
                            id: widget.following[index].id.toString(),
                            userName:
                                widget.following[index].userName.toString(),
                            email: widget.following[index].email.toString(),
                            profilePic:
                                widget.following[index].profilePic.toString(),
                            online: widget.following[index].online,
                            blocked: widget.following[index].blocked,
                            verified: widget.following[index].verified,
                            role: widget.following[index].role.toString(),
                            isPrivate: widget.following[index].isPrivate,
                            backGroundImage: widget
                                .following[index].backGroundImage
                                .toString(),
                            createdAt: widget.following[index].createdAt,
                            updatedAt: widget.following[index].updatedAt,
                            v: widget.following[index].v);
                        navigatePushAnimaterighttoleft(
                            context,
                            UserProfileScreen(
                                userId: widget.following[index].id.toString(),
                                user: user));
                      },
                      child: Text(
                        widget.following[index].userName.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text(
                      widget.following[index].name.toString(),
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    trailing: MaterialButton(
                        minWidth: 80,
                        height: 27,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: buttonclr)),
                        onPressed: () {
                          context.read<FollowUnfollowUserBloc>().add(
                              UnFollowUserButtonClickEvent(
                                  followeesId:
                                      widget.following[index].id.toString()));
                          setState(() {
                            widget.following.removeWhere((element) =>
                                element.id == widget.following[index].id);
                          });
                          widget.model.totalCount--;
                          context.read<FetchFollowersBloc>();
                        },
                        child: const Text('Unfollow',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: buttonclr,
                                fontSize: 13))),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
