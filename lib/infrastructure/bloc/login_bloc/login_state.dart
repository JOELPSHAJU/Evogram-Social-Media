part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoadingstate extends LoginState{}
final class LoginSuccessState extends LoginState{}
final class LoginErrorState extends LoginState{}
final class LoginErrorStateUsernotfound extends LoginState{}
final class LoginErrorStateInternalServerError extends LoginState{}
final class LoginErrorStateInvalidPassword extends LoginState{}
final class LoginErrorStateAccountisBlocked extends LoginState{}