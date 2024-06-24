// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/comment_model.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';

import 'package:evogram/presentation/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:evogram/presentation/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:evogram/presentation/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/bottomsheet.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/shimmer.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../bloc/like_unlike_post_bloc/like_post_bloc.dart';

class SavedPostsDetailsScreen extends StatefulWidget {
  final int initialindex;
  const SavedPostsDetailsScreen({
    super.key,
    required this.initialindex,
  });

  @override
  State<SavedPostsDetailsScreen> createState() =>
      _SavedPostsDetailsScreenState();
}

class _SavedPostsDetailsScreenState extends State<SavedPostsDetailsScreen> {
  List<SavedPostModel>? posts = [];

  @override
  void initState() {
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());

    super.initState();
  }

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
          title: appbarTitle(title: 'Saved Posts'),
        ),
        body: BlocConsumer<FetchSavedPostsBloc, FetchSavedPostsState>(
          listener: (context, state) {},
          builder: (context, statesaved) {
            if (statesaved is FetchSavedPostsLoadingState) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return shimmerWidgetpost(size, context);
                },
              );
            } else if (statesaved is FetchSavedPostsSuccesfulState) {
              posts = statesaved.posts;

              return ListView.builder(
                  controller: ScrollController(
                      initialScrollOffset: widget.initialindex * 550),
                  itemCount: statesaved.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    context.read<GetCommentsBloc>().add(CommentsFetchEvent(
                        postId: statesaved.posts[index].postId.id));

                    String formatDate(String dateStr) {
                      DateTime dateTime = DateTime.parse(dateStr);
                      DateFormat formatter = DateFormat('d MMMM yyyy');
                      return formatter.format(dateTime);
                    }

                    String formattedDate =
                        formatDate('${statesaved.posts[index].postId.date}');

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
                                    imageUrl: statesaved
                                        .posts[index].postId.userId.profilePic,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final user = UserIdSearchModel(
                                              id: statesaved
                                                  .posts[index].postId.userId.id
                                                  .toString(),
                                              userName: statesaved.posts[index]
                                                  .postId.userId.userName
                                                  .toString(),
                                              email: statesaved.posts[index]
                                                  .postId.userId.email
                                                  .toString(),
                                              profilePic: statesaved
                                                  .posts[index]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                  .postId
                                                  .userId
                                                  .profilePic
                                                  .toString(),
                                              online: statesaved.posts[index]
                                                  .postId.userId.online,
                                              blocked: statesaved.posts[index]
                                                  .postId.userId.blocked,
                                              verified: statesaved.posts[index].postId.userId.verified,
                                              role: statesaved.posts[index].postId.userId.role,
                                              isPrivate: statesaved.posts[index].postId.userId.isPrivate,
                                              backGroundImage: statesaved.posts[index].postId.userId.backGroundImage.toString(),
                                              createdAt: statesaved.posts[index].postId.userId.createdAt,
                                              updatedAt: statesaved.posts[index].postId.userId.updatedAt,
                                              v: statesaved.posts[index].postId.userId.v);
                                          navigatePushAnimaterbottomtotop(
                                              context,
                                              UserProfileScreen(
                                                  userId: statesaved
                                                      .posts[index]
                                                      .postId
                                                      .userId
                                                      .id
                                                      .toString(),
                                                  user: user));
                                        },
                                        child: Text(
                                          statesaved.posts[index].postId.userId
                                              .userName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        statesaved.posts[index].createdAt !=
                                                statesaved
                                                    .posts[index].updatedAt
                                            ? '${timeago.format(statesaved.posts[index].updatedAt)} (Edited)'
                                            : timeago.format(statesaved
                                                .posts[index].createdAt),
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
                                imageUrl: statesaved.posts[index].postId.image
                                    .toString(),
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
                                          if (!statesaved
                                              .posts[index].postId.likes
                                              .contains(useridprofilescreen)) {
                                            statesaved.posts[index].postId.likes
                                                .add(useridprofilescreen);
                                            context.read<LikePostBloc>().add(
                                                  LikePostButtonClickEvent(
                                                      postId: statesaved
                                                          .posts[index]
                                                          .postId
                                                          .id),
                                                );
                                          } else {
                                            statesaved.posts[index].postId.likes
                                                .remove(useridprofilescreen);
                                            context.read<LikePostBloc>().add(
                                                  UnlikePostButtonClickEvent(
                                                      postId: statesaved
                                                          .posts[index]
                                                          .postId
                                                          .id),
                                                );
                                          }
                                        },
                                        icon: Icon(
                                          statesaved.posts[index].postId.likes
                                                  .contains(useridprofilescreen)
                                              ? Iconsax.heart5
                                              : Iconsax.heart4,
                                          color: statesaved
                                                  .posts[index].postId.likes
                                                  .contains(useridprofilescreen)
                                              ? red
                                              : null,
                                        ),
                                      ),
                                      h10,
                                      GestureDetector(
                                        onTap: () {
                                          commentBottomSheet(
                                              context,
                                              statesaved.posts[index].postId,
                                              commentController,
                                              formkey: _formkey,
                                              comments: _comments,
                                              profiePic: profilepic,
                                              userName: usernameprofile,
                                              id: statesaved
                                                  .posts[index].postId.id);
                                        },
                                        child: const Icon(
                                          Iconsax.message,
                                        ),
                                      ),
                                      const Spacer(),
                                      posts != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (index <
                                                      statesaved.posts.length) {
                                                    final postId = statesaved
                                                        .posts[index].postId.id;

                                                    context
                                                        .read<SavedPostBloc>()
                                                        .add(
                                                            RemoveSavedPostButtonClickEvent(
                                                                postId:
                                                                    postId));

                                                    setState(() {
                                                      posts!.removeWhere(
                                                          (element) =>
                                                              element
                                                                  .postId.id ==
                                                              postId);
                                                    });
                                                    context
                                                        .read<
                                                            FetchSavedPostsBloc>()
                                                        .add(
                                                            SavedPostsInitialFetchEvent());
                                                    if (posts!.isEmpty) {
                                                      context
                                                          .read<
                                                              FetchSavedPostsBloc>()
                                                          .add(
                                                              SavedPostsInitialFetchEvent());
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  } else {
                                                    if (kDebugMode) {
                                                      print(
                                                          'Error: Index $index is out of range for statesaved.posts with length ${statesaved.posts.length}');
                                                    }
                                                  }
                                                },
                                                child: Icon(
                                                  size: 26,
                                                  posts!.any((element) =>
                                                          element.postId.id ==
                                                          statesaved
                                                              .posts[index]
                                                              .postId
                                                              .id)
                                                      ? Icons.bookmark
                                                      : Icons.bookmark_border,
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  statesaved
                                          .posts[index].postId.likes.isNotEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text:
                                                    '${statesaved.posts[index].postId.likes.length}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? black
                                                      : white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: statesaved
                                                                .posts[index]
                                                                .postId
                                                                .likes
                                                                .length >
                                                            1
                                                        ? ' likes'
                                                        : 'like',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? black
                                                            : white),
                                                  ),
                                                ]),
                                          ),
                                        )
                                      : const Text(
                                          '0 Likes',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 10),
                                      child: ReadMoreText(
                                        statesaved
                                            .posts[index].postId.description,
                                        trimMode: TrimMode.Line,
                                        trimLines: 2,
                                        colorClickableText: blue,
                                        trimCollapsedText: 'more.',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                        lessStyle: const TextStyle(
                                            fontSize: 14,
                                            color: grey,
                                            fontWeight: FontWeight.bold),
                                        trimExpandedText: 'show less',
                                        moreStyle: const TextStyle(
                                            fontSize: 14,
                                            color: grey,
                                            fontWeight: FontWeight.bold),
                                      ))
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? grey
                                      : grey),
                            ),
                          ),
                          h20,
                        ],
                      ),
                    );
                  });
            }
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return shimmerWidgetpost(size, context);
                });
          },
        ));
  }
}
