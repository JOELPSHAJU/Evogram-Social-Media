part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordState {}

final class ForgetpasswordInitial extends ForgetpasswordState {}
final class ForgetpasswordLoadingState extends ForgetpasswordState{}
final class ForgetpasswordSucessState extends ForgetpasswordState{}
final class ForgetpasswordErrorState extends ForgetpasswordState{}
