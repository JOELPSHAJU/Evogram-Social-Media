// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/comment_model.dart';
import 'package:evogram/domain/models/post_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:evogram/presentation/bloc/like_unlike_post_bloc/like_post_bloc.dart';
import 'package:evogram/presentation/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/bottomsheet.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailsUserPage extends StatefulWidget {
  final int initialindex;
  final List<Post> posts;

  const PostDetailsUserPage({
    super.key,
    required this.initialindex,
    required this.posts,
  });

  @override
  State<PostDetailsUserPage> createState() => _PostDetailsUserPageState();
}

class _PostDetailsUserPageState extends State<PostDetailsUserPage> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          shape: Border(
              bottom: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? lightgreyauth
                      : black,
                  width: 1.5)),
          title: appbarTitle(title: widget.posts.first.userId.userName),
        ),
        body: ListView.builder(
            controller: ScrollController(
                initialScrollOffset: widget.initialindex * 550),
            itemCount: widget.posts.length,
            itemBuilder: (BuildContext context, int index) {
              context
                  .read<GetCommentsBloc>()
                  .add(CommentsFetchEvent(postId: widget.posts[index].id));

              String formatDate(String dateStr) {
                DateTime dateTime = DateTime.parse(dateStr);
                DateFormat formatter = DateFormat('d MMMM yyyy');
                return formatter.format(dateTime);
              }

              String formattedDate = formatDate('${widget.posts[index].date}');

              return SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h10,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: widget.posts[index].userId.profilePic
                                  .toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return LoadingAnimationWidget.flickr(
                                    leftDotColor: blueaccent2,
                                    rightDotColor: blueaccent3,
                                    size: 23);
                              },
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final user = UserIdSearchModel(
                                        id: widget.posts[index].userId.id
                                            .toString(),
                                        userName: widget
                                            .posts[index].userId.userName
                                            .toString(),
                                        email: widget.posts[index].userId.email
                                            .toString(),
                                        profilePic: widget
                                            .posts[index].userId.profilePic
                                            .toString(),
                                        online:
                                            widget.posts[index].userId.online,
                                        blocked:
                                            widget.posts[index].userId.blocked,
                                        verified:
                                            widget.posts[index].userId.verified,
                                        role: widget.posts[index].userId.role
                                            .toString(),
                                        isPrivate: widget
                                            .posts[index].userId.isPrivate,
                                        backGroundImage: widget
                                            .posts[index].userId.backGroundImage
                                            .toString(),
                                        createdAt:
                                            widget.posts[index].userId.createdAt,
                                        updatedAt: widget.posts[index].userId.updatedAt,
                                        v: widget.posts[index].userId.v);
                                    navigatePushAnimaterbottomtotop(
                                        context,
                                        UserProfileScreen(
                                            userId: widget
                                                .posts[index].userId.id
                                                .toString(),
                                            user: user));
                                  },
                                  child: Text(
                                    widget.posts[index].userId.userName
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                                Text(
                                  widget.posts[index].createdAt !=
                                          widget.posts[index].updatedAt
                                      ? '${timeago.format(widget.posts[index].updatedAt)} (Edited)'
                                      : timeago.format(
                                          widget.posts[index].createdAt),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    h10,
                    SizedBox(
                        height: size.width * .84,
                        width: size.width,
                        child: CachedNetworkImage(
                          imageUrl: widget.posts[index].image.toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return LoadingAnimationWidget.hexagonDots(
                                color: blueaccent, size: 30);
                          },
                        )),
                    MultiBlocConsumer(
                      buildWhen: null,
                      blocs: [
                        context.watch<LikePostBloc>(),
                        context.watch<SavedPostBloc>()
                      ],
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (!widget.posts[index].likes
                                        .contains(useridprofilescreen)) {
                                      widget.posts[index].likes
                                          .add(useridprofilescreen);
                                      context.read<LikePostBloc>().add(
                                            LikePostButtonClickEvent(
                                                postId: widget.posts[index].id),
                                          );
                                    } else {
                                      widget.posts[index].likes
                                          .remove(useridprofilescreen);
                                      context.read<LikePostBloc>().add(
                                            UnlikePostButtonClickEvent(
                                                postId: widget.posts[index].id),
                                          );
                                    }
                                  },
                                  icon: Icon(
                                    widget.posts[index].likes
                                            .contains(useridprofilescreen)
                                        ? Iconsax.heart5
                                        : Iconsax.heart4,
                                    color: widget.posts[index].likes
                                            .contains(useridprofilescreen)
                                        ? red
                                        : null,
                                  ),
                                ),
                                h10,
                                GestureDetector(
                                  onTap: () {
                                    commentBottomSheet(context,
                                        widget.posts[index], commentController,
                                        formkey: _formkey,
                                        comments: _comments,
                                        profiePic: profilepic,
                                        userName: usernameprofile,
                                        id: widget.posts[index].id);
                                  },
                                  child: const Icon(
                                    Iconsax.message,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? grey
                                    : grey),
                      ),
                    ),
                    h20,
                  ],
                ),
              );
            }));
  }
}
