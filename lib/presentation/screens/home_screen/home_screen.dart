// ignore_for_file: use_build_context_synchronously

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/sharedpreferences.dart';
import 'package:evogram/application/socket/socket.dart';
import 'package:evogram/presentation/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:evogram/presentation/bloc/profile_details_bloc/profile_details_bloc.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/home_page_loading.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/custom_profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../application/core/constants.dart';
import '../suggessions_screen/suggession_screen.dart';
import 'list_tile_main.dart';

String logginedUserToken = '';
String logginedUserId = '';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;

  @override
  void initState() {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent(n: currentPage));
    context.read<ProfileDetailsBloc>().add(ProfileInitialDetailsFetchEvent());
    getToken();
    SocketService().connectSocket(context: context);
    super.initState();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent(n: currentPage));
  }

  getToken() async {
    logginedUserToken = (await getUsertoken())!;
    logginedUserId = (await getUserId())!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        surfaceTintColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        elevation: 1,
        shadowColor: Theme.of(context).brightness == Brightness.light
            ? lightgrey
            : darkgrey,
        automaticallyImplyLeading: false,
        title: Theme.of(context).brightness == Brightness.light
            ? Image.asset(
                logoletters,
                width: size.width * .2,
              )
            : Image.asset(
                logoletterswhite,
                width: size.width * .2,
              ),
        actions: [
          GestureDetector(
              onTap: () {
                navigatePushAnimaterighttoleft(
                    context, const SuggessionScreen());
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    addperson,
                    width: 35,
                  )))
        ],
      ),
      body: CustomMaterialIndicator(
        indicatorBuilder: (context, controller) {
          return LoadingAnimationWidget.inkDrop(
            color: blue,
            size: 30,
          );
        },
        onRefresh: refresh,
        child: BlocConsumer<AllFollowersPostsBloc, AllFollowersPostsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AllFollowersPostsSuccesfulState) {
              var posts = state.posts;
              return posts.isEmpty
                  ? Container(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300
                          : black,
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no data found.jpg',
                            width: size.width * .5,
                          ),
                          h10,
                          const Text(
                            'Looks a little quiet around here!',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          h10,
                          const Text(
                            textAlign: TextAlign.center,
                            'Follow some awesome people to see their posts.',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          h20,
                          SizedBox(
                            width: size.width * .55,
                            child: GestureDetector(
                              onTap: () {
                                navigatePushAnimaterighttoleft(
                                    context, const SuggessionScreen());
                              },
                              child: CustomProfileButton(
                                  size: size,
                                  text: 'See some suggession?',
                                  width: size.width * .5),
                            ),
                          ),
                          h40,
                          h10
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ListTileMainScreen(
                          posts: posts,
                        )
                      ],
                    );
            } else if (state is AllFollowersPostsLoadingState) {
              return homepageloading(context);
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
