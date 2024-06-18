import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/domain/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'fetch_saved_posts_event.dart';
part 'fetch_saved_posts_state.dart';

class FetchSavedPostsBloc
    extends Bloc<FetchSavedPostsEvent, FetchSavedPostsState> {
  FetchSavedPostsBloc() : super(FetchSavedPostsInitial()) {
    on<FetchSavedPostsEvent>((event, emit) {});
    on<SavedPostsInitialFetchEvent>(savedPostsInitialFetchEvent);
  }

  FutureOr<void> savedPostsInitialFetchEvent(SavedPostsInitialFetchEvent event,
      Emitter<FetchSavedPostsState> emit) async {
    emit(FetchSavedPostsLoadingState());
    final Response result = await MainPostRepo.fetchSavedPosts();
    final responseBody = jsonDecode(result.body);
    final List data = responseBody;
    debugPrint('saved post fetch statuscode-${result.statusCode}');
    if (result.statusCode == 200) {
      final List<SavedPostModel> posts =
          data.map((json) => SavedPostModel.fromJson(json)).toList();
      emit(FetchSavedPostsSuccesfulState(posts: posts));
    } else if (result.statusCode == 500) {
      emit(FetchSavedPostsServerErrorState());
    } else {
      emit(FetchSavedPostsErrorState());
    }
  }
}
