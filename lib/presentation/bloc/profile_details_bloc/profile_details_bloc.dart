// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/suggession_user_model.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';



part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc
    extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  ProfileDetailsBloc() : super(ProfileDetailsInitial()) {
    on<ProfileDetailsEvent>((event, emit) {});
    on<ProfileInitialDetailsFetchEvent>(profileInitialDetailsFetchEvent);
  }

  FutureOr<void> profileInitialDetailsFetchEvent(
      ProfileInitialDetailsFetchEvent event,
      Emitter<ProfileDetailsState> emit) async {
    emit(ProfileDetailsFetchLoadingState());
    final Response result = await LoginUserRepo.fetchloginuser();
    final responseBody = jsonDecode(result.body);
    if (result.statusCode == 200) {
      final User user = User.fromJson(responseBody);
     return emit(ProfileDetailsFetchSuccesfulState(user: user));
    } else if (responseBody['status'] == 404) {
     return emit(ProfileDetailsFetchUserNotFoundState());
    } else if (responseBody['status'] == 500) {
     return emit(ProfileDetailsFetchServerErrorState());
    }
  }
}
