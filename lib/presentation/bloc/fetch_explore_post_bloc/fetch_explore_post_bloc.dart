import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/fetch_explore_post_model.dart';
import 'package:evogram/domain/repository/post_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

part 'fetch_explore_post_event.dart';
part 'fetch_explore_post_state.dart';

class FetchExplorePostBloc
    extends Bloc<FetchExplorePostEvent, FetchExplorePostState> {
  FetchExplorePostBloc() : super(FetchExplorePostInitial()) {
    on<FetchExplorePostEvent>((event, emit) {});
    on<ExplorePostInitialFetchEvent>(explorePostInitialFetchEvent);
  }

  FutureOr<void> explorePostInitialFetchEvent(
      ExplorePostInitialFetchEvent event,
      Emitter<FetchExplorePostState> emit) async {
    emit(FetchExplorePostLoadingState());
    final Response result = await MainPostRepo.fetchExplorePosts();
    final responseBody = jsonDecode(result.body);
    final List data = responseBody;
    debugPrint('explore post statucode-${result.statusCode}');
    List<ExplorePostModel> posts =
        data.map((e) => ExplorePostModel.fromJson(e)).toList();
    if (result.statusCode == 200) {
      emit(FetchExplorePostSuccesfulState(posts: posts));
    }
  }
}
