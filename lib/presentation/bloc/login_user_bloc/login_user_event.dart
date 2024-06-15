part of 'login_user_bloc.dart';

@immutable
sealed class LoginUserEvent {}
final class LoginUserInitialFetchingEvent extends LoginUserEvent {}