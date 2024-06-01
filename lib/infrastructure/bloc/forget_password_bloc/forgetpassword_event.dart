part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordEvent {}

final class ForgetPasswordButtonClicked extends ForgetpasswordEvent {
  final String email;
  ForgetPasswordButtonClicked({required this.email});
}
