part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoadingState extends OtpState {}

final class OtpSuccessState extends OtpState {}

final class OtpErrorState extends OtpState {}
final class OtpErrorStateInvalidOtp extends OtpState{}
final class OtpErrorStateInternalServerError extends OtpState{}