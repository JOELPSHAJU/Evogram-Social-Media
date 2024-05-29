import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:evogram/application/models/signup_model.dart';
import 'package:evogram/domain/repository/signup_repo.dart';
import 'package:flutter/material.dart';


part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<SignupButtenClickEvent>(signupevent);
  }

  FutureOr<void> signupevent(
      SignupButtenClickEvent event, Emitter<SignupState> emit) async {
    String response = await SignupRepo.signupuser(user: event.user);
    debugPrint(response);
    emit(SignupLoadingState());

    if (response == 'Successful') {
      emit(SignupSuccessState());
    } else if (response == 'You already have an account') {
      emit(SignupErrorStateAlreadyAccount());
    } else if (response == 'OTP already sent within the last one minute') {
      emit(SignupErrorStateOtpalreadySent());
    }else if (response == 'The username is already taken.') {
      emit(SignupErrorStateUsernamealreadyUsed());
    }  else if (response == 'Internal server Error') {
      emit(SignupErrorStateInternalServerError());
    } else {
      emit(SignupErrorState());
    }
  }
}