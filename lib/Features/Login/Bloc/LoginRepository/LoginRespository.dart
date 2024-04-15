import 'dart:async';
import 'package:job_portal/Features/Login/Model/LoginResponse.dart';
import '../LoginDataProvider/LoginDataProvider.dart';

class LoginRepository {
  final loginProvider = LoginDataProvider();

  Future<GetOTPResponse> getOTP(String email, String role) =>
      loginProvider.getOTP(email, role);

  Future<LoginResponse> getLoginResponse(String email, String otp) =>
      loginProvider.signIn(email, otp);
}
