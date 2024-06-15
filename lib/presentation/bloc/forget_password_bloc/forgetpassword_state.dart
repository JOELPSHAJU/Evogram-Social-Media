part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordState {}

final class ForgetpasswordInitial extends ForgetpasswordState {}

final class ForgetpasswordLoadingState extends ForgetpasswordState {}

final class ForgetpasswordSucessState extends ForgetpasswordState {}

final class OtpverifiedLoadingState extends ForgetpasswordState {}
final class ResetpasswordLoadingState extends ForgetpasswordState {}

final class ResetPasswordErrorState extends ForgetpasswordState {
  final String error;

  ResetPasswordErrorState({required this.error});
}

final class ResetPasswordSuccesState extends ForgetpasswordState {}

final class OtpverifiedSuccesState extends ForgetpasswordState {}

final class OtpverifiedErrorState extends ForgetpasswordState {
  final String error;

  OtpverifiedErrorState({required this.error});
}

final class ForgetpasswordErrorState extends ForgetpasswordState {
  final String error;
  ForgetpasswordErrorState({required this.error});
}
