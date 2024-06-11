
import 'dart:convert';

import 'package:evogram/domain/models/post_models.dart';
import 'package:evogram/domain/repository/user_post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'fetching_user_post_event.dart';
part 'fetching_user_post_state.dart';

class FetchingUserPostBloc
    extends Bloc<FetchingUserPostEvent, FetchingUserPostState> {
  FetchingUserPostBloc() : super(FetchingUserPostInitial()) {
    on<FetchingUserpostInitialEvent>(
      (event, emit) async {
        final Response response = await PostRepo.fetchPost();
        List<Postmodel> posts = [];

        if (response.statusCode == 200) {
          final List<dynamic> responsedata = jsonDecode(response.body);
          for (int i = 0; i < responsedata.length; i++) {
            Postmodel post =
                Postmodel.fromJson(responsedata[i] as Map<String, dynamic>);
            posts.add(post);
          }
          emit(FetchUserPostSuccessState(userposts: posts));
        } else if (response.statusCode == 500) {
          emit(FetchUserPostsErrorInternalErrorState());
        } else {
          emit(FetchUserPostsErrorState());
        }
      },
    );
    on<DeletePostClickEvent>((event, emit) async {
      emit(DeleteLoadingState());
      var response = await PostRepo.deletePost(event.postId);
      if (response != null && response.statusCode == 200) {
        add(FetchingUserpostInitialEvent());
       
        return emit(DeleteSucessState());
      } else if (response != null) {
     
        var responseBody = jsonDecode(response.body);
        return emit(DeleteErrorState(error: responseBody["message"]));
      } else {
        
        return emit(DeleteErrorState(error: 'Something went wrong'));
      }
    });
  }
}
