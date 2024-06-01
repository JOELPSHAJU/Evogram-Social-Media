import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/signup_repo.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc
    extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordInitial()) {
    on<ForgetpasswordEvent>((event, emit) {});
    on<ForgetPasswordButtonClicked>(
      (event, emit) async {
        emit(ForgetpasswordLoadingState());
        var response = await SignupRepo.resetPassSendOtp(event.email);
        if (response != null && response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody["status"] == 200) {
            return emit(ForgetpasswordSucessState());
          } else {
            return emit(
                ForgetpasswordErrorState(error: responseBody["message"]));
          }
        } else {
          return emit(ForgetpasswordErrorState(error: 'something went wrong'));
        }
      },
    );
    on<OnVerifyButtonClickedEvent>(
      (event, emit) async {
        emit(OtpverifiedLoadingState());
        var response =
            await SignupRepo.verifyOtpPasswordReset(event.email, event.otp);
        if (response != null && response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          if (responseBody["status"]) {
            return emit(OtpverifiedSuccesState());
          } else {
            print(responseBody);
            return emit(OtpverifiedErrorState(error: 'invalid OTP'));
          }
        } else {
          return emit(OtpverifiedErrorState(error: 'something went wrong'));
        }
      },
    );

    on<OnResetPasswordButtonClickedEvent>(
      (event, emit) async {
        emit(ResetpasswordLoadingState());
        var response =
            await SignupRepo.updatePassword(event.email, event.password);
        if (response != null && response.statusCode == 200) {
          return emit(ResetPasswordSuccesState());
        } else if (response != null) {
          var finalResponse = jsonDecode(response.body);
          return emit(ResetPasswordErrorState(error: finalResponse["message"]));
        } else {
          return emit(ResetPasswordErrorState(error: 'Something went wrong'));
        }
      },
    );
  }
}
