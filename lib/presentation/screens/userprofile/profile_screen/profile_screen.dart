import 'package:evogram/domain/models/login_user.dart';
import 'package:evogram/domain/models/model_user.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:evogram/presentation/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:evogram/presentation/screens/settings_screen/settings_screen.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/debouncer.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/savedpost/savedpost_grid.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/grid.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/profile_header.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../application/core/constants.dart';

import 'package:flutter/material.dart';

String useridprofilescreen = '';
String profilepic = '';
String usernameprofile = '';
LoginUserModel loginuserinfo = LoginUserModel(
    id: 'id',
    userName: 'userName',
    email: 'email',
    phone: 'phone',
    online: false,
    blocked: false,
    verified: false,
    role: 'role',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    profilePic:
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png',
    backGroundImage:
        'https://img.freepik.com/free-vector/copy-space-bokeh-spring-lights-background_52683-55649.jpg');
UserModelPost userinfopost = UserModelPost(
    id: 'id',
    userName: 'userName',
    email: 'email',
    profilePic:
        'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png',
    backGroundImage:
        'https://img.freepik.com/free-vector/copy-space-bokeh-spring-lights-background_52683-55649.jpg',
    phone: 'phone',
    online: false,
    blocked: false,
    verified: false,
    role: 'role',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    v: 1);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const nointernetimage = "assets/nointernet.png";

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
    context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
    context.read<FetchFollowingsBloc>().add(FollowingsInitialFetchEvent());
    context.read<FetchFollowersBloc>().add(FetchFollowersInitialEvent());
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    super.initState();
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> fetchDataProfileWithDebounce() async {
    await debouncer.run(() async {
      context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
      context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
      context.read<FetchFollowingsBloc>().add(FollowingsInitialFetchEvent());
      context.read<FetchFollowersBloc>().add(FetchFollowersInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginUserBloc, LoginUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginUserSucessState) {
          useridprofilescreen = state.users.id;
          usernameprofile = state.users.userName.toString();
          profilepic = state.users.profilePic.toString();
          loginuserinfo = state.users;
          userinfopost = UserModelPost(
              id: state.users.id,
              userName: state.users.userName,
              email: state.users.email,
              profilePic: state.users.profilePic,
              backGroundImage: state.users.backGroundImage,
              phone: state.users.phone,
              online: state.users.online,
              blocked: state.users.blocked,
              verified: state.users.verified,
              role: state.users.role,
              isPrivate: state.users.isPrivate,
              createdAt: state.users.createdAt,
              updatedAt: state.users.updatedAt,
              v: 1);
          return Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[300]
                  : black,
              extendBody: true,
              appBar: AppBar(
                elevation: 5,
                shadowColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[300]
                    : black,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? white
                        : black,
                surfaceTintColor:
                    Theme.of(context).brightness == Brightness.light
                        ? white
                        : black,
                automaticallyImplyLeading: false,
                toolbarHeight: 50,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.users.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigatePushAnimaterighttoleft(
                            context, const SettingsScreen());
                      },
                      icon: const Icon(
                        Icons.more_vert,
                      ))
                ],
              ),
              body: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                      headerSliverBuilder: (context, _) {
                        return [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            profileHeaderWidgets(
                              context,
                              state,
                              size,
                            )
                          ]))
                        ];
                      },
                      body: Column(
                        children: [
                          Material(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey[300]
                                    : black,
                            child: TabBar(
                                overlayColor:
                                    WidgetStatePropertyAll(Colors.grey[300]),
                                dividerColor: blueaccent3,
                                unselectedLabelColor: grey,
                                labelColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? black
                                    : white,
                                indicatorColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? black
                                    : white,
                                tabs: const [
                                  Tab(
                                    icon: Icon(
                                      Icons.grid_on_sharp,
                                      size: 30,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.bookmark_outline,
                                      size: 30,
                                    ),
                                  )
                                ]),
                          ),
                          Expanded(
                              child: TabBarView(children: [
                            BlocConsumer<FetchingUserPostBloc,
                                FetchingUserPostState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is FetchUserPostLoadingState) {
                                  return Center(
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                              color: blueaccent2, size: 40));
                                } else if (state is FetchUserPostSuccessState) {
                                  return GridviewProfile(
                                    state: state,
                                  );
                                }
                                return Center(
                                  child: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Image.asset(
                                          nopostblack,
                                          color: black,
                                          width: size.width * .4,
                                        )
                                      : Image.asset(nopostwht,
                                          width: size.width * .5),
                                );
                              },
                            ),
                            BlocConsumer<FetchSavedPostsBloc,
                                FetchSavedPostsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is FetchSavedPostsLoadingState) {
                                  return Center(
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                              color: blueaccent2, size: 40));
                                } else if (state
                                    is FetchSavedPostsSuccesfulState) {
                                  return SavedPostGrid(
                                    saveddata: state.posts,
                                  );
                                }
                                return Center(
                                  child: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Image.asset(
                                          nopostblack,
                                          color: black,
                                          width: size.width * .4,
                                        )
                                      : Image.asset(nopostwht,
                                          width: size.width * .5),
                                );
                              },
                            )
                          ]))
                        ],
                      ))));
        }
        return SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                nointernetimage,
                width: size.width,
              ),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              h10,
              const Text(
                textAlign: TextAlign.center,
                'You are not connected to the internet.\nMake sure Mobile data is on, Airplane Mode is off\nand try again',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: grey, fontSize: 14),
              ),
              h40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo2,
                    width: size.width * .2,
                  ),
                  w10,
                  Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? logoletters
                        : logoletterswhite,
                    width: size.width * .3,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
