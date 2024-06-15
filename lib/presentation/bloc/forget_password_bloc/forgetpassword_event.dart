part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordEvent {}

final class ForgetPasswordButtonClicked extends ForgetpasswordEvent {
  final String email;
  ForgetPasswordButtonClicked({required this.email});
}
final class OnVerifyButtonClickedEvent extends ForgetpasswordEvent {
  final String email;
  final String otp;

  OnVerifyButtonClickedEvent({required this.email, required this.otp});

}
final class OnResetPasswordButtonClickedEvent extends ForgetpasswordEvent {
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent({required this.email, required this.password});



}