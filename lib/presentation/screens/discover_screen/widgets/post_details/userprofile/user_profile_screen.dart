import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_all_conversations_bloc.dart/fetch_all_conversations_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/follow_unfollow_user_bloc/follow_unfollow_user_bloc.dart';
import 'package:evogram/presentation/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:evogram/presentation/bloc/profile_posts_bloc/profile_bloc.dart';
import 'package:evogram/presentation/screens/chat_screen/chat_screen.dart';
import 'package:evogram/presentation/screens/discover_screen/post_details/post_details.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/posts_loading.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/specific_uploadedpost.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/custom_profile_button.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String postcount = '';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  // ignore: prefer_typing_uninitialized_variables
  final UserIdSearchModel user;

  UserProfileScreen({super.key, required this.userId, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Following> followings = [];
  @override
  void initState() {
    context
        .read<ProfileBloc>()
        .add(ProfileInitialPostFetchEvent(userId: widget.userId));
    context.read<FetchFollowingsBloc>().add(FollowingsInitialFetchEvent());
    context
        .read<GetConnectionsBloc>()
        .add(ConnectionsInitilFetchEvent(userId: widget.userId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          title: appbarTitle(title: widget.user.userName),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade300
            : black,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 210,
                width: size.width,
                decoration: BoxDecoration(
                    color: blueaccent,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.backGroundImage),
                        fit: BoxFit.cover)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -60,
                      left: 20,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 5,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey.shade300
                                    : black),
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: widget.user.profilePic,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return ClipOval(
                                child: Image.asset(
                                  profile,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h40,
              h30,
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.user.name != null
                      ? widget.user.name.toString()
                      : 'Guest User',
                  style: profilestyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  widget.user.bio != null ? widget.user.bio.toString() : '',
                  style: profilestyle2,
                ),
              ),
              h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ProfilePostFetchSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.posts.length.toString(),
                              style: profilestyle,
                            ),
                            Text(state.posts.length < 2 ? 'Post' : 'Posts',
                                style: profilestyle2)
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Post', style: profilestyle2)
                        ],
                      );
                    },
                  ),
                  BlocConsumer<GetConnectionsBloc, GetConnectionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetConnectionsSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.followersCount.toString(),
                              style: profilestyle,
                            ),
                            Text(
                                state.followersCount < 2
                                    ? 'Follower'
                                    : 'Followers',
                                style: profilestyle2),
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Followers', style: profilestyle2),
                        ],
                      );
                    },
                  ),
                  BlocConsumer<GetConnectionsBloc, GetConnectionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetConnectionsSuccesfulState) {
                        return Column(
                          children: [
                            Text(
                              state.followingsCount.toString(),
                              style: profilestyle,
                            ),
                            Text(
                                state.followingsCount < 2
                                    ? 'Following'
                                    : 'Followings',
                                style: profilestyle2)
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Text(
                            '0',
                            style: profilestyle,
                          ),
                          Text('Following', style: profilestyle2),
                        ],
                      );
                    },
                  ),
                ],
              ),
              h30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<FetchFollowingsBloc, FetchFollowingsState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is FetchFollowingsSuccesfulState) {
                        final FollowingModel followingsModel =
                            state.followingsModel;
                        followings = followingsModel.following;
                      }
                      return GestureDetector(
                          onTap: () {
                            bool isFollowing = followings.any(
                                (following) => following.id == widget.userId);
                            if (isFollowing) {
                              followings.removeWhere(
                                  (element) => element.id == widget.userId);
                              context.read<FollowUnfollowUserBloc>().add(
                                  UnFollowUserButtonClickEvent(
                                      followeesId: widget.userId));
                              context
                                  .read<FetchFollowingsBloc>()
                                  .add(FollowingsInitialFetchEvent());
                              context.read<GetConnectionsBloc>().add(
                                  ConnectionsInitilFetchEvent(
                                      userId: widget.userId));
                            } else {
                              followings.add(Following(
                                  id: widget.userId,
                                  userName: widget.user.userName,
                                  email: widget.user.email,
                                  password: widget.user.password ?? '',
                                  phone: widget.user.phone,
                                  online: widget.user.online,
                                  blocked: widget.user.blocked,
                                  verified: widget.user.verified,
                                  role: widget.user.role,
                                  isPrivate: widget.user.isPrivate,
                                  createdAt: widget.user.createdAt,
                                  updatedAt: widget.user.updatedAt,
                                  v: widget.user.v,
                                  profilePic: widget.user.profilePic,
                                  backGroundImage:
                                      widget.user.backGroundImage));
                              context.read<FollowUnfollowUserBloc>().add(
                                  FollowUserButtonClickEvent(
                                      followeesId: widget.userId));
                              context
                                  .read<FetchFollowingsBloc>()
                                  .add(FollowingsInitialFetchEvent());
                              context.read<GetConnectionsBloc>().add(
                                  ConnectionsInitilFetchEvent(
                                      userId: widget.userId));
                            }
                          },
                          child: CustomProfileButton(
                            size: size,
                            text: followings.any((following) =>
                                    following.id == widget.userId)
                                ? 'Unfollow'
                                : 'Follow',
                            width: .4,
                          ));
                    },
                  ),
                  BlocConsumer<ConversationBloc, ConversationState>(
                    listener: (context, state) {
                      if (state is ConversationSuccesfulState) {
                        context
                            .read<FetchAllConversationsBloc>()
                            .add(AllConversationsInitialFetchEvent());
                        navigatePushAnimaterbottomtotop(
                            context,
                            ChatScreen(
                              username: widget.user.userName,
                              recieverid: widget.userId,
                              name: widget.user.name.toString(),
                              profilepic: widget.user.profilePic,
                              conversationId: state.conversationId,
                            ));
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<ConversationBloc>().add(
                              CreateConversationButtonClickEvent(
                                  members: [loginuserinfo.id, widget.user.id]));
                        },
                        child: CustomProfileButton(
                          size: size,
                          text: 'Message',
                          width: .4,
                        ),
                      );
                    },
                  ),
                ],
              ),
              h30,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: Icon(
                    Icons.grid_on_sharp,
                    size: 30,
                  )),
                  Text(
                    ' Posts',
                    style: profilestyle,
                  )
                ],
              ),
              h10,
              const Divider(
                thickness: 1,
                height: 1,
              ),
              h10,
              Flexible(
                flex: 0,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfilePostFetchSuccesfulState) {
                      final posts = state.posts;

                      return posts.isEmpty
                          ? Center(
                              child: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Image.asset(
                                      nopostblack,
                                      color: black,
                                      width: size.width * .4,
                                    )
                                  : Image.asset(nopostwht,
                                      width: size.width * .5),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    navigatePushAnimaterbottomtotop(
                                        context,
                                        PostDetailsUserPage(
                                            posts: state.posts,
                                            initialindex: index));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.0),
                                      child: Image.network(
                                        state.posts[index].image,
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    } else if (state is ProfilePostFetchLoadingState) {
                      return postsShimmerLoading();
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
