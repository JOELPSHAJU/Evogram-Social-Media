import 'dart:async';

import 'package:evogram/domain/repository/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginButtonClickEvent>(loginevent);
  }

  FutureOr<void> loginevent(
      LoginButtonClickEvent event, Emitter<LoginState> emit) async {
         emit(LoginLoadingstate());
    String response = await SignupRepo.userlogin(
        email: event.email, password: event.password);
    debugPrint(response);
   
    if (response == 'login successful') {
      emit(LoginSuccessState());
    } else if (response == 'User not found with the provided email') {
      emit(LoginErrorStateUsernotfound());
    } else if (response == 'internal server error') {
      emit(LoginErrorStateInternalServerError());
    } else if (response == 'Invalid password') {
      emit(LoginErrorStateInvalidPassword());
    } else if (response == 'account is blocked') {
      emit(LoginErrorStateAccountisBlocked());
    } else {
      emit(LoginErrorState());
    }
  }
}