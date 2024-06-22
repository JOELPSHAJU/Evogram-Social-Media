import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/post_model.dart';
import 'package:evogram/domain/repository/main_user_repo.dart';
import 'package:evogram/presentation/screens/widgets/parse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileInitialPostFetchEvent>(profileInitialPostFetchEvent);
  }

  FutureOr<void> profileInitialPostFetchEvent(
      ProfileInitialPostFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfilePostFetchLoadingState());
    debugPrint('event user id is -${event.userId}');
    final Response result = await UserRepo.fetchUserPosts(userId: event.userId);
    final responseBody = jsonDecode(result.body);
    final List<Post> posts = parsePosts(result.body);
    debugPrint('user posts:-$responseBody');

    if (result.statusCode == 200) {
      emit(ProfilePostFetchSuccesfulState(posts: posts));
    } else if (responseBody['status'] == 404) {
      emit(ProfilePostFetchUserNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(ProfilePostFetchServerErrorState());
    } else {
      emit(ProfilePostFetchErrorState());
    }
  }

  // FutureOr<void> profileInitialDetailsFetchEvent(
  //     ProfileInitialDetailsFetchEvent event, Emitter<ProfileState> emit) async {
  //   emit(ProfileDetailsFetchLoadingState());
  //   final Response result = await PostRepo.fetchLoggedInUserDetails();
  //   final responseBody = jsonDecode(result.body);
  //   print('user details:-$responseBody');
  //   if (result.statusCode == 200) {
  //     final User user = User.fromJson(responseBody);
  //     emit(ProfileDetailsFetchSuccesfulState(user: user));
  //   } else if (responseBody['status'] == 404) {
  //     emit(ProfileDetailsFetchUserNotFoundState());
  //   } else if (responseBody['status'] == 500) {
  //     emit(ProfileDetailsFetchServerErrorState());
  //   }
  // }
}
