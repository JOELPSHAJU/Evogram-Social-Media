import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/profile_posts_bloc/profile_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/posts_loading.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/screens/widgets/custom_profile_button.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  // ignore: prefer_typing_uninitialized_variables
  final UserIdSearchModel user;
  const UserProfileScreen(
      {super.key, required this.userId, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    context.read<FetchFollowingsBloc>().add(FollowingsInitialFetchEvent());
    context
        .read<ProfileBloc>()
        .add(ProfileInitialPostFetchEvent(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade300
              : black,
          surfaceTintColor: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade300
              : black,
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
              // MultiBlocBuilder(
              //   blocs: [
              //     context.watch<FollowUnfollowUserBloc>(),
              //     context.watch<ProfileDetailsBloc>(),
              //     context.watch<ProfileBloc>(),
              //     context.watch<FetchFollowingsBloc>(),
              //   ],
              //   builder: (p0, p1) {

              //   },
              // ),
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
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '1',
                          style: profilestyle,
                        ),
                        Text('Posts', style: profilestyle2)
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '30',
                          style: profilestyle,
                        ),
                        Text('Followers', style: profilestyle2),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '0',
                          style: profilestyle,
                        ),
                        Text('Following', style: profilestyle2)
                      ],
                    )
                  ]),
              h30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: CustomProfileButton(
                        size: size,
                        text: 'Follow',
                        width: .4,
                      )),
                  GestureDetector(
                    onTap: () {},
                    child: CustomProfileButton(
                      size: size,
                      text: 'Message',
                      width: .4,
                    ),
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
                  listener: (context, state) {
                    // TODO: implement listener
                  },
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
                                      crossAxisCount: 2),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      state.posts[index].image,
                                      fit: BoxFit.cover,
                                      width: 300,
                                      height: 200,
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
