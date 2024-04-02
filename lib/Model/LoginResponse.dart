// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class GetOTPResponse extends Equatable {
  final bool success;
  final String message;

  const GetOTPResponse(this.message, {required this.success});

  factory GetOTPResponse.fromJson(Map<String, dynamic> json) {
    String message = json['message'];
    bool success = false;
    if (message.contains("An otp has been sent")) {
      success = true;
    } else {
      success = false;
    }
    return GetOTPResponse(message, success: success);
  }

  @override
  List<Object?> get props => [success];
}

class LoginResponse extends Equatable {
  final bool success;
  final String message;

  const LoginResponse(this.message, {required this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    String message = json['message'];
    bool success = false;
    if (message.contains("login")) {
      success = true;
    } else {
      success = false;
    }
    return LoginResponse(message, success: success);
  }

  @override
  List<Object?> get props => [success, message];
}
