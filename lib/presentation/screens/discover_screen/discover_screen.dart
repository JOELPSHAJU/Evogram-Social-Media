import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/domain/models/fetch_explore_post_model.dart';
import 'package:evogram/presentation/bloc/fetch_explore_post_bloc/fetch_explore_post_bloc.dart';
import 'package:evogram/presentation/bloc/search_all_users_bloc/search_all_users_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/explore_page_list_view_shimmer.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/post_details.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../application/core/constants.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isTaped = true;

  TextEditingController searchText = TextEditingController(text: '');
  final _debouncer = Debouncer(milliseconds: 700);
  String onchangevalue = '';

  @override
  void initState() {
    context.read<FetchExplorePostBloc>().add(ExplorePostInitialFetchEvent());
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
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Discover'),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    onchangevalue = value;
                  });
                  if (value.isNotEmpty) {
                    _debouncer.run(() {
                      context
                          .read<SearchAllUsersBloc>()
                          .add(SearchUserInitilEvent(query: value));
                    });
                  }
                },
                cursorWidth: 2,
                controller: searchText,
                cursorColor: Theme.of(context).brightness == Brightness.light
                    ? black
                    : white,
                style: const TextStyle(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightgrey
                            : black,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightgrey
                            : black,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightgrey
                            : black,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightgrey
                            : black,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? lightgrey
                            : black,
                      )),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? lightgrey
                      : darkgreymain,
                  filled: true,
                  hintText: 'Search',
                ),
              )),
        ),
      ),
      body: BlocConsumer<FetchExplorePostBloc, FetchExplorePostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchExplorePostSuccesfulState) {
            if (onchangevalue.isEmpty) {
              return Center(
                child: MasonryGridView.builder(
                    semanticChildCount: 3,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final ExplorePostModel post = state.posts[index];
                      return Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: GestureDetector(
                            onTap: () {
                              navigatePushAnimaterbottomtotop(context,
                                  UsersPostDetailsList(initialindex: index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: post.image,
                                  placeholder: (context, url) {
                                    return LoadingAnimationWidget.stretchedDots(
                                        color: blue, size: 30);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return BlocBuilder<SearchAllUsersBloc, SearchAllUsersState>(
                builder: (context, state) {
                  if (state is SearchAllUsersSuccesfulState) {
                    return state.users.isEmpty
                        ? const Center(
                            child: Text(
                              'No User Found !',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return Center(
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 500),
                                  child: GestureDetector(
                                      onTap: () {
                                        navigatePushAnimaterbottomtotop(
                                            context,
                                            UserProfileScreen(
                                              userId: user.id,
                                              user: user,
                                            ));
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: white,
                                          radius: 28,
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(user.profilePic),
                                            radius: 26,
                                          ),
                                        ),
                                        title: Text(
                                          user.userName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: user.name != null
                                            ? Text(
                                                user.name.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : h10,
                                      )),
                                ),
                              );
                            });
                  } else if (state is SearchAllUsersLoadingState) {
                    return explorePageLoading(context);
                  } else {
                    print(state);
                    return Center(
                        child: LoadingAnimationWidget.discreteCircle(
                      color: black,
                      size: 40,
                    ));
                  }
                },
              );
            }
          } else if (state is FetchExplorePostLoadingState) {
            return explorePageLoading(context);
          } else {
            return Center(
              child: Text('error'),
            );
          }
        },
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
