import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetOTP extends LoginEvent {
  final String email;
  final String role;
  GetOTP({required this.email, required this.role});
}

class SignIN extends LoginEvent {
  final String email;
  final String otp;
  SignIN({required this.email, required this.otp});
}
