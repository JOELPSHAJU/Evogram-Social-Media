part of 'login_user_bloc.dart';

@immutable
sealed class LoginUserState {}

final class LoginUserInitial extends LoginUserState {}

final class LoginUserLoadingState extends LoginUserState {}

final class LoginUserSucessState extends LoginUserState {
  final LoginUserModel users;

  LoginUserSucessState({required this.users});
}

final class LoginUserErrorState extends LoginUserState {}
