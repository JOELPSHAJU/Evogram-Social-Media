// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';


import 'package:evogram/domain/repository/signup_repo.dart';

import 'package:evogram/presentation/login_screen/googlesigninfn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
   on<LoginButtonClickEvent>((event, emit) async {
      emit(LoginLoadingstate());
      final response =
          await SignupRepo.userlogin(email: event.email, password: event.password);
      if (response != null && response.statusCode == 200) {
        return emit(LoginSuccessState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);
        return emit(LoginErrorState(error: responseData["message"]));
      } else {
        return emit(LoginErrorState(error: 'something went wrong'));
      }
    });
    on<GoogleLoginButtonClickEvent>(
      (event, emit) async {
        emit(GoogleAuthenticationLoadingState());

        var response = await siginWithGoogle();

        // ignore: unnecessary_null_comparison
        if (response != null && response.user?.email != null) {
          var email = response.user!.email;

          Response? finalresponse = await SignupRepo.googleLogin(email!);
          if (finalresponse != null && finalresponse.statusCode == 200) {
            return emit(LoginSuccessState());
          } else if (finalresponse != null) {
            final responebody = jsonDecode(finalresponse.body);
            emit(GoogleAuthenticationErrorState(error: responebody['message']));
          }
        }
      },
    );
  }

  FutureOr<void> loginevent(
      LoginButtonClickEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingstate());

    Response? response = await SignupRepo.userlogin(
        email: event.email, password: event.password);
    print(response);
    if (response != null && response.statusCode == 200) {
      emit(LoginSuccessState());
    } else if (response != null ) {
      final responebody = await jsonDecode(response.body);

      emit(LoginErrorState(error: responebody["message"]));
    } else {
      emit(LoginErrorState(error: 'Something Went Wrong'));
    }
  }
}
