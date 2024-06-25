// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/get_followers_post_model.dart';
import 'package:evogram/domain/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
part 'all_followers_posts_event.dart';
part 'all_followers_posts_state.dart';

class AllFollowersPostsBloc
    extends Bloc<AllFollowersPostsEvent, AllFollowersPostsState> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  AllFollowersPostsBloc() : super(const AllFollowersPostsInitial(null)) {
    scrollController.addListener(() {
      add(LoadMoreEvent());
    });
    on<AllFollowersPostsEvent>((event, emit) {});
    on<AllFollowersPostsInitialFetchEvent>(allFollowersPostsInitialFetchEvent);
    on<LoadMoreFollowersPostsEvent>(
        (event, emit) => loadMoreEvent(event, emit));
  }

  FutureOr<void> allFollowersPostsInitialFetchEvent(
      AllFollowersPostsInitialFetchEvent event,
      Emitter<AllFollowersPostsState> emit) async {
    emit(const AllFollowersPostsLoadingState(null));
  
    final Response result = await MainPostRepo.getFollowersPost(page: page);
    List<FollwersPostModel> followersposts = [];
    final responseBody = jsonDecode(result.body);

    final List data = responseBody;
    debugPrint(result.statusCode.toString());
    debugPrint('get follwers post-${result.body}');
    if (result.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        FollwersPostModel followerspost =
            FollwersPostModel.fromJson(data[i] as Map<String, dynamic>);
        followersposts.add(followerspost);
      }

      return emit(AllFollowersPostsSuccesfulState(posts: followersposts));
    } else if (responseBody['status'] == 500) {
      return emit(const AllFollowersPostsServerErrorState(null));
    }
  }

  FutureOr<void> loadMoreEvent(
    LoadMoreFollowersPostsEvent event,
    Emitter<AllFollowersPostsState> emit,
  ) async {
    if (state is AllFollowersPostsSuccesfulState) {
      final currentState = state as AllFollowersPostsSuccesfulState;
      final int currentPage = currentState.posts.length ~/ 5 + 1;

      final Response response =
          await MainPostRepo.fetchfollowespost(n: currentPage);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<FollwersPostModel> newPosts = [];

        for (int i = 0; i < responseData.length; i++) {
          FollwersPostModel followersPost = FollwersPostModel.fromJson(
              responseData[i] as Map<String, dynamic>);
          newPosts.add(followersPost);
        }

        List<FollwersPostModel> updatedPosts = List.of(currentState.posts)
          ..addAll(newPosts);
        emit(AllFollowersPostsSuccesfulState(posts: updatedPosts));
      } else {
        emit(AllFollowersPostsServerErrorState(null));
      }
    }
  }
}
