import 'package:evogram/infrastructure/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:evogram/presentation/settings_screen/settings_screen.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/debouncer.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/example.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/grid.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/profile_header.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants.dart';

import 'package:flutter/material.dart';

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
    super.initState();
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> fetchDataProfileWithDebounce() async {
    await debouncer.run(() async {
      context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
      context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginUserBloc, LoginUserState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        if (state is LoginUserSucessState) {
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
                                      Icons.save_outlined,
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
                            GridviewProfileExample()
                          ]))
                        ],
                      ))));
        }
        return SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                nointernetimage,
                width: size.width * .7,
              ),
              const Text(
                'Oops!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blueaccent3,
                    fontSize: 24),
              ),
              const Text(
                'No Internet Connection',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blueaccent3,
                    fontSize: 20),
              ),
              const Text(
                'Check your Network',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blueaccent2,
                    fontSize: 18),
              )
            ],
          ),
        );
      },
    );
  }
}
