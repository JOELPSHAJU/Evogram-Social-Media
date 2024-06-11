// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/post_models.dart';
import 'package:evogram/domain/repository/user_post_repo.dart';
import 'package:http/http.dart';

import 'package:meta/meta.dart';

part 'fetch_post_event.dart';
part 'fetch_post_state.dart';

class FetchPostBloc extends Bloc<FetchPostEvent, FetchPostState> {
  FetchPostBloc() : super(FetchPostInitial()) {
    on<FetchPostEvent>((event, emit) {});
    on<FetchPostInitialEvent>(fetchpostevent);
  }
  FutureOr<void> fetchpostevent(
      FetchPostInitialEvent event, Emitter<FetchPostState> emit) async {
    emit(FetchPostLoadingState());
    final Response response = await PostRepo.fetchPost();

    List<Postmodel> posts = [];
    if (response.statusCode == 200) {
      final List<dynamic> responsedata = jsonDecode(response.body);
      for (int i = 0; i < responsedata.length; i++) {
        Postmodel post =
            Postmodel.fromJson(responsedata[i] as Map<String, dynamic>);
        posts.add(post);
      }
      emit(FetchPostSuccessState(posts: posts));
    } else if (response.statusCode == 500) {
      emit(FetchPostErrorStateInternalserverError());
    } else {
      emit(FetchPostErrorState());
    }
  }
}
