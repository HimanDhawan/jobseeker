import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal/Features/Login/Model/LoginResponse.dart';

class LoginDataProvider {
  Future<GetOTPResponse> getOTP(String email, String role) async {
    final response = await http.post(
        Uri.parse("http://job-portal.ap-1.evennode.com/api/v1/auth/send"),
        body: jsonEncode(<String, String>{'email': email, 'role': role}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return GetOTPResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bad request');
    }
  }

  Future<LoginResponse> signIn(String email, String otp) async {
    final response = await http.post(
        Uri.parse("http://job-portal.ap-1.evennode.com/api/v1/auth/verify"),
        body: jsonEncode(<String, String>{'email': email, 'otp': otp}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Bad request');
    }
  }
}
