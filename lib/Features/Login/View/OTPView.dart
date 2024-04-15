import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/Features/Login/Bloc/Event/LoginEvent.dart';
import 'package:job_portal/Features/Login/Bloc/LoginBloc.dart';

class OTPView extends StatefulWidget {
  final String userName;
  const OTPView({super.key, required this.userName});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  String opt = '';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Text(
          "Provide the OTP code we just sent to your email",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.redAccent,
            primaryColorDark: Colors.red,
          ),
          child: SizedBox(
            height: 80,
            child: TextFormField(
              initialValue: opt,
              onChanged: (value) {
                opt = value.toString();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter valid OTP';
                }
                return null;
              },
              // ignore: deprecated_member_use
              maxLength: 6,
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your OTP',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          if (opt.isEmpty) {
            print("Not valid OTP");
            return;
          }
          print("valid OTP");
          context
              .read<LoginBloc>()
              .add(SignIN(email: widget.userName, otp: opt));
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width / 1.3, 25),
          backgroundColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      TextButton(
        onPressed: () {
          // Add functionality to go back here
        },
        child: const Text("Back"),
      )
    ]);
  }
}
