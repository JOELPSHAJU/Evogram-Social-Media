part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class SignupLoadingState extends SignupState{}
final class SignupSuccessState extends SignupState{}
final class SignupErrorState extends SignupState{}
final class SignupErrorStateAlreadyAccount extends SignupState{} 
final class SignupErrorStateOtpalreadySent extends SignupState{}
final class SignupErrorStateUsernamealreadyUsed extends SignupState{}
final class SignupErrorStateInternalServerError extends SignupState{}