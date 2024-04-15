import 'package:equatable/equatable.dart';

enum LoginStatus {
  initial,
  getCodeSuccess,
  getCodeFailure,
  getCodeLoading,
  signInLoading,
  optIntial,
  otpSuccess,
  otpFailure
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? error;
  const LoginState({this.error, required this.status});

  LoginState copyWith(LoginStatus loginSuccess) {
    return LoginState(error: error, status: loginSuccess);
  }

  LoginState copyWithError(String? err, LoginStatus loginSuccess) {
    return LoginState(error: err, status: loginSuccess);
  }

  @override
  List<Object?> get props => [status];
}
