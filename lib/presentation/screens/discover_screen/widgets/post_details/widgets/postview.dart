import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:evogram/domain/models/comment_model.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:evogram/presentation/bloc/like_unlike_post_bloc/like_post_bloc.dart';
import 'package:evogram/presentation/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/bottomsheet.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

final _formkey = GlobalKey<FormState>();
List<Comment> _comments = [];
final commentController = TextEditingController();

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.post,
    required this.image,
    required this.likes,
    required this.description,
    required this.id,
    required this.userId,
    required this.saved,
    this.posts,
    this.hidden,
    required this.creartedAt,
    required this.updatedAt,
    this.taggedUsers,
    required this.blocked,
    this.date,
    this.tags,
    required this.profilePic,
    required this.userName,
    required this.edited,
    required this.v,
    required this.email,
    required this.online,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.background,
  });
  final String description;
  final String profilePic;
  final String userName;
  final int v;
  final String image;
  final List likes;
  final post;
  final String email;
  final bool online;
  final bool verified;
  final String role;
  final bool isPrivate;
  final DateTime createdAt;
  final String background;

  final DateTime edited;
  final String id;
  final String userId;
  final bool saved;
  final List<SavedPostModel>? posts;
  final bool? hidden;
  final DateTime creartedAt;
  final DateTime updatedAt;
  final List? taggedUsers;
  final bool blocked;
  final DateTime? date;
  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Align(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(profilePic),
                  ),
                  w10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final user = UserIdSearchModel(
                              id: id,
                              userName: userName,
                              email: email,
                              profilePic: profilePic,
                              online: online,
                              blocked: blocked,
                              verified: verified,
                              role: role,
                              isPrivate: isPrivate,
                              backGroundImage: background,
                              createdAt: createdAt,
                              updatedAt: updatedAt,
                              v: v);
                          navigatePushAnimaterbottomtotop(context,
                              UserProfileScreen(userId: userId, user: user));
                        },
                        child: Text(
                          userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Text(
                        creartedAt != updatedAt
                            ? '${timeago.format(updatedAt)} (Edited)'
                            : timeago.format(creartedAt),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
                height: size.width * .84,
                width: size.width,
                child: CachedNetworkImage(
                  imageUrl: image.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return LoadingAnimationWidget.hexagonDots(
                        color: blueaccent, size: 30);
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiBlocConsumer(
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
                          GestureDetector(
                            onTap: () {
                              // isLiked = !isLiked;
                              if (!likes.contains(useridprofilescreen)) {
                                likes.add(useridprofilescreen);
                                context.read<LikePostBloc>().add(
                                      LikePostButtonClickEvent(postId: id),
                                    );
                              } else {
                                likes.remove(useridprofilescreen);
                                context.read<LikePostBloc>().add(
                                      UnlikePostButtonClickEvent(postId: id),
                                    );
                              }
                            },
                            child: Icon(
                              likes.contains(useridprofilescreen)
                                  ? Iconsax.heart5
                                  : Iconsax.heart4,
                              color: likes.contains(useridprofilescreen)
                                  ? red
                                  : null,
                            ),
                          ),
                          w10,
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<GetCommentsBloc>()
                                  .add(CommentsFetchEvent(postId: id));
                              commentBottomSheet(
                                  context, post, commentController,
                                  formkey: _formkey,
                                  comments: _comments,
                                  profiePic: profilePic,
                                  userName: userName,
                                  id: id);
                            },
                            child: const Icon(
                              Iconsax.message,
                            ),
                          ),
                          const Spacer(),
                          posts != null
                              ? GestureDetector(
                                  onTap: () {
                                    if (posts!.any(
                                        (element) => element.postId.id == id)) {
                                      context.read<SavedPostBloc>().add(
                                          RemoveSavedPostButtonClickEvent(
                                              postId: id));
                                      posts!.removeWhere(
                                          (element) => element.postId.id == id);
                                    } else {
                                      posts!.add(SavedPostModel(
                                          userId: userId,
                                          postId: PostId(
                                              id: id,
                                              userId: UserIdSavedPost.fromJson(
                                                  userinfopost.toJson()),
                                              image: image,
                                              description: description,
                                              likes: [],
                                              hidden: hidden!,
                                              blocked: blocked!,
                                              tags: tags!,
                                              date: date!,
                                              createdAt: creartedAt,
                                              updatedAt: updatedAt,
                                              v: 0,
                                              taggedUsers: taggedUsers!),
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          v: 0));
                                      context.read<SavedPostBloc>().add(
                                          SavePostButtonClickEvent(postId: id));
                                    }
                                  },
                                  child: Icon(
                                    size: 26,
                                    posts!.any((element) =>
                                            element.postId.id == id)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      h10,
                      likes.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: '${likes.length}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? black
                                          : white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: likes.length > 1
                                            ? ' likes'
                                            : ' like',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? black
                                                    : white),
                                      ),
                                    ]),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: '0 ',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? black
                                          : white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'likes',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? black
                                                    : white),
                                      ),
                                    ]),
                              ),
                            ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 10),
                          child: ReadMoreText(
                            description,
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: blue,
                            trimCollapsedText: ' more.',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            lessStyle: const TextStyle(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.bold),
                            trimExpandedText: ' show less',
                            moreStyle: const TextStyle(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
