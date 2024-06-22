// ignore_for_file: must_be_immutable
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/fetch_explore_post_model.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/presentation/bloc/fetch_explore_post_bloc/fetch_explore_post_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/widgets/postview.dart';
import 'package:evogram/presentation/screens/home_screen/widgets/home_page_loading.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPostDetailsList extends StatefulWidget {
  final int initialindex;
  const UsersPostDetailsList({
    super.key,
    required this.initialindex,
  });

  @override
  State<UsersPostDetailsList> createState() => _UsersPostDetailsListState();
}

class _UsersPostDetailsListState extends State<UsersPostDetailsList> {
  @override
  void initState() {
    context.read<FetchExplorePostBloc>().add(ExplorePostInitialFetchEvent());
    super.initState();
  }

  List<ExplorePostModel> posts = [];
  List<SavedPostModel> savedPosts = [];

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
        title: appbarTitle(title: 'My Posts'),
      ),
      body: MultiBlocBuilder(
        blocs: [
          context.watch<FetchExplorePostBloc>(),
          context.watch<FetchSavedPostsBloc>(),
        ],
        builder: (context, state) {
          var state1 = state[0];
          var state2 = state[1];
          if (state2 is FetchSavedPostsSuccesfulState) {
            savedPosts = state2.posts;
          }
          if (state1 is FetchExplorePostSuccesfulState) {
            posts = state1.posts;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      controller: ScrollController(
                        initialScrollOffset: widget.initialindex == 0
                            ? 0
                            : widget.initialindex * 450.0,
                      ),
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostView(
                          v: post.userId.v,
                          online: post.userId.online,
                          verified: post.userId.verified,
                          role: post.userId.role,
                          isPrivate: post.userId.isPrivate,
                          createdAt: post.userId.createdAt,
                          background: post.userId.backGroundImage,
                          email: post.userId.email,
                          edited: post.editedAt,
                          saved: true,
                          post: post.userId,
                          image: post.image,
                          likes: post.likes,
                          description: post.description,
                          id: post.id,
                          userId: post.userId.id,
                          posts: savedPosts,
                          taggedUsers: post.taggedUsers,
                          blocked: post.blocked,
                          hidden: post.hidden,
                          creartedAt: post.createdAt,
                          updatedAt: post.updatedAt,
                          date: post.date,
                          tags: const [],
                          profilePic: post.userId.profilePic,
                          userName: post.userId.userName,
                        );
                      }),
                )
              ],
            );
          } else if (state1 is FetchExplorePostLoadingState) {
            return homepageloading(context);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
