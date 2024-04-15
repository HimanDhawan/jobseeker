import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
      home: Scaffold(
          appBar: AppBar(
              title:
                  Text("User Profile", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.indigoAccent),
          resizeToAvoidBottomInset: true,
          body: UserProfileContainer()),
    );
  }
}

class UserProfileContainer extends StatefulWidget {
  const UserProfileContainer({super.key});

  @override
  State<UserProfileContainer> createState() => _UserProfileContainer();
}

class _UserProfileContainer extends State<UserProfileContainer> {
  TextEditingController dateController = TextEditingController();
  bool isFresher = false;
  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Enter your profile information',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter valid first name';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your Name',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter valid email';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your email',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 0, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Gender",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSegmentedControl<int>(
                        children: {0: Text("Male"), 1: Text("Female")},
                        onValueChanged: (groupValue) {}),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dateController,
              readOnly: true,
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: "Your date of birth",
                prefixIcon: Icon(Icons.calendar_today),
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime(
                        1950), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(
                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(
                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  print(
                      formattedDate); //formatted date output using intl package =>  2022-07-04
                  //You can format date as per your need

                  setState(() {
                    dateController.text =
                        formattedDate; //set foratted date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter valid first name';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your Phone number',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter valid first name';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your Current Salary',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 0, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Are you Fresher?",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                Checkbox(
                    value: isFresher,
                    onChanged: (value) {
                      setState(() {
                        isFresher = value ?? false;
                      });
                    })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter heading for bio';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your heading for profile',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: null,
              initialValue: "",
              onChanged: (value) {},
              validator: (value) {
                print("value $value");
                var valueString = value as String;
                if (valueString.isEmpty) {
                  return 'Please enter bio';
                }
                return null;
              },
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: 'Your bio',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(title: Text("Add experience"), children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: null,
                  initialValue: "",
                  onChanged: (value) {},
                  validator: (value) {
                    print("value $value");
                    var valueString = value as String;
                    if (valueString.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  // ignore: deprecated_member_use
                  scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Colors.indigoAccent,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: null,
                  initialValue: "",
                  onChanged: (value) {},
                  validator: (value) {
                    print("value $value");
                    var valueString = value as String;
                    if (valueString.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  // ignore: deprecated_member_use
                  scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                  decoration: const InputDecoration(
                    labelText: 'Company',
                    labelStyle: TextStyle(
                      color: Colors.indigoAccent,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                child: TextFormField(
                  maxLines: null,
                  initialValue: "",
                  onChanged: (value) {},
                  validator: (value) {
                    print("value $value");
                    var valueString = value as String;
                    if (valueString.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  // ignore: deprecated_member_use
                  scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      color: Colors.indigoAccent,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Is this your current employer?",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    Checkbox(
                        value: isFresher,
                        onChanged: (value) {
                          setState(() {
                            isFresher = value ?? false;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 1.15, 25),
                    backgroundColor: Colors.indigoAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10.0,
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    ));
  }
}
