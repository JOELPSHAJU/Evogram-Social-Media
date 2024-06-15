
part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class UserSignupEvent extends SignupEvent {}

class SignupButtenClickEvent extends SignupEvent {
  final UserModel user;
  SignupButtenClickEvent({required this.user});
}
