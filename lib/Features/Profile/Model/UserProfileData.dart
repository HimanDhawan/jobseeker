import 'dart:ffi';

import 'package:equatable/equatable.dart';

enum Gender { male, female }

class UserProfileData {
  String name = "";
  String email = "";
  Gender gender = Gender.male;
  String dateOfBirth = "";
  String phoneNumber = "";
  String currentSalary = "";
  bool isFresher = false;
  String heading = "";
  String yourBio = "";
  List<Company> companies = [];
  List<Education> education = [];
}

class Company {
  String title = "";
  String company = "";
  String location = "";
  String description = "";
  bool isCurrentCompany = false;
  String startDate = "";
  String endDate = "";
}

class Education {
  String schoolName = "";
  String degree = "";
  String field = "";
  String grade = "";
  bool isCurrentCompany = false;
  String startDate = "";
  String endDate = "";
}
