part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

final class OtpverifyClickevent extends OtpEvent {
  final String email;
  final String otp;

  OtpverifyClickevent({required this.email, required this.otp});
}
