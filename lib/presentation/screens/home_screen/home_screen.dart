import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:evogram/presentation/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:evogram/presentation/bloc/profile_details_bloc/profile_details_bloc.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/home_page_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../application/core/constants.dart';
import 'list_tile_main.dart';
import '../suggessions_screen/suggession_screen.dart';
import 'package:flutter/material.dart';

String logginedUserToken = '';
String logginedUserId = '';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    context.read<ProfileDetailsBloc>().add(ProfileInitialDetailsFetchEvent());
    super.initState();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
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
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SuggessionScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Iconsax.user_add,
                  color: white,
                  size: 30,
                ),
              ))
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
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No posts',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          h10,
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
