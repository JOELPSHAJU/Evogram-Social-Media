import 'dart:async';

import 'package:evogram/domain/repository/signup_repo.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpEvent>((event, emit) {});
    on<OtpverifyClickevent>(otpEvent);
  }

  FutureOr<void> otpEvent(
      OtpverifyClickevent event, Emitter<OtpState> emit) async {
    final response =
        await SignupRepo.verifyOtp(email: event.email, oteepee: event.otp);
    emit(OtpLoadingState());
    if (response == 'successful') {
      emit(OtpSuccessState());
    } else if (response == 'Invalid verification code or OTP expired') {
      emit(OtpErrorStateInvalidOtp());
    } else if (response == 'Internal server error') {
      emit(OtpErrorStateInternalServerError());
    } else {
      emit(OtpErrorState());
    }
  }
}
