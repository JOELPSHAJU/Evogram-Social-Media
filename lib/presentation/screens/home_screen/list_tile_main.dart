import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/domain/models/get_followers_post_model.dart';
import 'package:evogram/domain/models/postuser_model%20copy.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/domain/models/suggession_user_model.dart';
import 'package:evogram/presentation/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:evogram/presentation/bloc/like_unlike_post_bloc/like_post_bloc.dart';
import 'package:evogram/presentation/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/bottomsheet.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../application/core/constants.dart';
import '../../../domain/models/comment_model.dart';
import '../../../domain/models/get_followers_userid_model.dart';
import '../../bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import '../../bloc/get_comments_bloc/get_comments_bloc.dart';

class ListTileMainScreen extends StatefulWidget {
  final List posts;

  const ListTileMainScreen({
    super.key,
    required this.posts,
  });

  @override
  State<ListTileMainScreen> createState() => _ListTileMainScreenState();
}

UserPostModel? logginedUserdetails;

class _ListTileMainScreenState extends State<ListTileMainScreen> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  List<SavedPostModel> posts = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
          shrinkWrap: false,
          itemCount: context.read<AllFollowersPostsBloc>().isLoadingMore
              ? widget.posts.length + 1
              : widget.posts.length,
          controller: context.read<AllFollowersPostsBloc>().scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.posts.length) {
              return context.read<AllFollowersPostsBloc>().isLoadingMore
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 200,
                      ),
                    )
                  : Container();
            } else {
              final FollwersPostModel post = widget.posts[index];
              String formatDate(String dateStr) {
                DateTime dateTime = DateTime.parse(dateStr);
                DateFormat formatter = DateFormat('d MMMM yyyy');
                return formatter.format(dateTime);
              }

              String formattedDate = formatDate('${post.date}');

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          post.userId.profilePic.toString()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.userId.userName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: post.createdAt != post.updatedAt
                                              ? '${timeago.format(post.updatedAt)} '
                                              : timeago.format(post.createdAt),
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? grey
                                                  : white),
                                          children: <TextSpan>[
                                        TextSpan(
                                          text: post.createdAt != post.updatedAt
                                              ? '(Edited)'
                                              : '',
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? blueaccent
                                                    : blueaccent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ])),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      h10,
                      SizedBox(
                          height: size.width * .84,
                          width: size.width,
                          child: CachedNetworkImage(
                            imageUrl: post.image.toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Center(
                                child: LoadingAnimationWidget.flickr(
                                    leftDotColor: blueaccent,
                                    rightDotColor: blueaccent2,
                                    size: 27),
                              );
                            },
                          )),
                      MultiBlocBuilder(
                        blocs: [
                          context.watch<LikePostBloc>(),
                          context.watch<FetchSavedPostsBloc>(),
                          context.watch<SavedPostBloc>(),
                        ],
                        builder: (context, state) {
                          var state2 = state[1];
                          if (state2 is FetchSavedPostsSuccesfulState) {
                            posts = state2.posts;
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        final currentUserId =
                                            useridprofilescreen;
                                        final isLiked = post.likes.any(
                                            (user) => user.id == currentUserId);
                                        if (!isLiked) {
                                          post.likes.add(
                                              FollowersUserIdModel.fromJson(User(
                                                      id: loginuserinfo.id,
                                                      userName: loginuserinfo
                                                          .userName,
                                                      email:
                                                          loginuserinfo.email,
                                                      profilePic: loginuserinfo
                                                          .profilePic,
                                                      phone:
                                                          loginuserinfo.phone,
                                                      online:
                                                          loginuserinfo.online,
                                                      blocked:
                                                          loginuserinfo.blocked,
                                                      verified: loginuserinfo
                                                          .verified,
                                                      createdAt: loginuserinfo
                                                          .createdAt,
                                                      updatedAt: loginuserinfo
                                                          .updatedAt,
                                                      v: 1,
                                                      role: loginuserinfo.role,
                                                      backGroundImage:
                                                          loginuserinfo
                                                              .backGroundImage,
                                                      isPrivate: loginuserinfo
                                                          .isPrivate)
                                                  .toJson()));

                                          context.read<LikePostBloc>().add(
                                              LikePostButtonClickEvent(
                                                  postId: post.id.toString()));
                                        } else {
                                          post.likes.removeWhere((user) =>
                                              user.id == currentUserId);
                                          context.read<LikePostBloc>().add(
                                              UnlikePostButtonClickEvent(
                                                  postId: post.id.toString()));
                                        }
                                      },
                                      icon: Icon(
                                        post.likes.any((user) =>
                                                user.id == useridprofilescreen)
                                            ? Iconsax.heart5
                                            : Iconsax.heart4,
                                        color: post.likes.any((user) =>
                                                user.id == useridprofilescreen)
                                            ? red
                                            : null,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        context.read<GetCommentsBloc>().add(
                                            CommentsFetchEvent(
                                                postId: post.id.toString()));
                                        commentBottomSheet(
                                            context, post, commentController,
                                            formkey: _formkey,
                                            userName: usernameprofile,
                                            profiePic: post.userId.profilePic
                                                .toString(),
                                            comments: _comments,
                                            id: post.id.toString());
                                      },
                                      icon: const Icon(
                                        Iconsax.message4,
                                        size: 25,
                                      )),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (posts.any((element) =>
                                        element.postId.id == post.id)) {
                                      context.read<SavedPostBloc>().add(
                                          RemoveSavedPostButtonClickEvent(
                                              postId: post.id.toString()));
                                      posts.removeWhere((element) =>
                                          element.postId.id == post.id);
                                    } else {
                                      posts.add(SavedPostModel(
                                          userId: post.userId.id.toString(),
                                          postId: PostId(
                                              id: post.id.toString(),
                                              userId: UserIdSavedPost.fromJson(
                                                  post.userId.toJson()),
                                              image: post.image.toString(),
                                              description:
                                                  post.description.toString(),
                                              likes: post.likes,
                                              hidden: post.hidden,
                                              blocked: post.blocked,
                                              tags: post.tags,
                                              date: post.date,
                                              createdAt: post.createdAt,
                                              updatedAt: post.updatedAt,
                                              v: post.v,
                                              taggedUsers: post.taggedUsers),
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          v: post.v));
                                      if (kDebugMode) {
                                        print(posts);
                                      }
                                      context.read<SavedPostBloc>().add(
                                          SavePostButtonClickEvent(
                                              postId: post.id.toString()));
                                      context
                                          .read<FetchSavedPostsBloc>()
                                          .add(SavedPostsInitialFetchEvent());
                                    }
                                  },
                                  icon: Icon(
                                    posts.any((element) =>
                                            element.postId.id == post.id)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    size: 25,
                                  ))
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Liked by',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? black
                                      : white),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Guest.dfjsdf ',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'and others',
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? black
                                          : white),
                                ),
                              ]),
                        ),
                      ),
                      h10,
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          post.description.toString(),
                          maxLines: 3,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? grey
                                  : grey),
                        ),
                      ),
                      h10,
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
