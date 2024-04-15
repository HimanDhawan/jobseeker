import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/Features/Login/Bloc/Event/LoginEvent.dart';
import 'package:job_portal/Features/Login/Bloc/LoginBloc.dart';
import 'package:job_portal/Features/Login/Bloc/LoginRepository/LoginRespository.dart';
import 'package:job_portal/Features/Login/Bloc/State/LoginState.dart';
import 'package:job_portal/Features/Login/View/OTPView.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job portal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginRepository: LoginRepository()),
        )
      ], child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
        backgroundColor: Colors.indigoAccent,
        resizeToAvoidBottomInset: true,
        body: LoginContainer());
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  String username = '';
  String role = "recruiter";

  void updateUsername(String newUsername) {
    setState(() {
      username = newUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
          print("Logic state changes");
          if (state.status == LoginStatus.getCodeLoading) {
            print("Loading");
            return Stack(alignment: AlignmentDirectional.center, children: [
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: LoginView(
                      status: state.status,
                      userName: username,
                      role: role,
                      onUsernameChanged: updateUsername),
                ),
              ),
              const Center(
                child: CircularProgressIndicator(),
              )
            ]);
          } else if (state.status == LoginStatus.getCodeSuccess) {
            print("loginSuccess");
            return Align(
              alignment: FractionalOffset.center,
              child: Container(
                height: 330,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: OTPView(userName: username),
              ),
            );
          } else if (state.status == LoginStatus.signInLoading) {
            print("loginSuccess");
            return Stack(alignment: AlignmentDirectional.center, children: [
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: OTPView(userName: username),
                ),
              ),
              const Center(
                child: CircularProgressIndicator(),
              )
            ]);
          }
          {
            return Align(
              alignment: FractionalOffset.center,
              child: Container(
                height: 330,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: LoginView(
                    status: state.status,
                    userName: username,
                    role: role,
                    onUsernameChanged: updateUsername),
              ),
            );
          }
        }, listener: (context, state) {
          if (state.status == LoginStatus.getCodeFailure) {
            Widget okButton = TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            );

            AlertDialog alert = AlertDialog(
              title: const Text("Error"),
              content: Text(state.error.toString()),
              actions: [okButton],
            );
            showDialog(
                context: context,
                builder: (context) {
                  return alert;
                });
          } else if (state.status == LoginStatus.otpFailure) {
            Widget okButton = TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            );

            AlertDialog alert = AlertDialog(
              title: const Text("Error"),
              content: Text(state.error.toString()),
              actions: [okButton],
            );
            showDialog(
                context: context,
                builder: (context) {
                  return alert;
                });
          }
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  LoginStatus status;
  String userName;
  String role;
  final Function(String) onUsernameChanged;
  LoginView({
    super.key,
    required this.status,
    required this.userName,
    required this.role,
    required this.onUsernameChanged,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            "Job Seeker Sign In",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width / 1.3, 25),
            backgroundColor: Color.fromARGB(255, 234, 234, 238),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5.0,
          ),
          child: const Text(
            'G Sign in with google',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(
                  color: Color.fromARGB(255, 218, 203, 203),
                  endIndent: 0,
                  thickness: 1,
                ),
              ),
              Text("OR"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(
                  color: Color.fromARGB(255, 218, 203, 203),
                  endIndent: 5,
                  thickness: 1,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: SizedBox(
              height: 80,
              child: TextFormField(
                initialValue: widget.userName,
                onChanged: (value) {
                  widget.onUsernameChanged(value);
                  widget.userName = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  print("value $value");
                  var valueString = value as String;
                  if (valueString.isValidEmail()) {
                    return null;
                  }
                  return 'Please enter valid email';
                },
                // ignore: deprecated_member_use
                maxLength: 30,
                scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                decoration: const InputDecoration(
                  labelText: 'Your email address',
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
            if (!widget.userName.isValidEmail()) {
              Widget okButton = TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              );

              AlertDialog alert = AlertDialog(
                title: const Text("Error"),
                content: const Text("Please enter valid email"),
                actions: [okButton],
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  });
              return;
            }
            print("valid email");
            context
                .read<LoginBloc>()
                .add(GetOTP(email: widget.userName, role: widget.role));
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
            'Get code',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: RichText(
            text: const TextSpan(
              text: 'By signing up, you agree to ',
              style: TextStyle(
                color: Colors.black, // Color for the default text
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Terms of service',
                  style: TextStyle(
                    color: Colors
                        .indigoAccent, // Color for the "Terms of service" text
                  ),
                  // Add any other style properties here if needed
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
