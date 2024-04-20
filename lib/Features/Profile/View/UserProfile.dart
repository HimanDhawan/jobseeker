import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/Features/Profile/Model/UserProfileData.dart';

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
  TextEditingController dateOfBirthController = TextEditingController();
  Company company = Company();
  Education education = Education();
  TextEditingController startDateExperience = TextEditingController();
  TextEditingController endDateExperience = TextEditingController();
  TextEditingController startEducationController = TextEditingController();
  TextEditingController endEducationController = TextEditingController();
  bool isFresher = false;

  UserProfileData profileData = UserProfileData();

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
          basicInformationWidget(context),
          const SizedBox(height: 20),
          const Divider(),
          basic2InformationWidget(context),
          const SizedBox(height: 0),
          const SizedBox(height: 20),
          const Divider(),
          basicProfileWidget(context),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          if (!profileData.isFresher) const Divider(),
          if (!profileData.isFresher) getExperienceWidget(context),
          const Divider(),
          getEducationWidget(context),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                String alertData = "";
                if (profileData.name.isEmpty) {
                  alertData = "Please enter name";
                } else if (profileData.email.isEmpty) {
                  alertData = "Please enter email";
                } else if (profileData.dateOfBirth.isEmpty) {
                  alertData = "Please enter date of birth";
                } else if (profileData.phoneNumber.isEmpty) {
                  alertData = "Please enter phone number";
                } else if (!profileData.isFresher &&
                    profileData.currentSalary.isEmpty) {
                  alertData = "Please enter current salary";
                } else if (profileData.education.isEmpty) {
                  alertData = "Please add education";
                } else if (!profileData.isFresher &&
                    profileData.companies.isEmpty) {
                  alertData = "Please add experience";
                }

                if (!alertData.isEmpty) {
                  Widget okButton = TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: const Text("Error"),
                    content: Text(alertData),
                    actions: [okButton],
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width / 1.15, 25),
                backgroundColor: Colors.indigoAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10.0,
              ),
              child: const Text(
                'Save profile',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget getEducationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(title: Text("Add education"), children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: null,
            initialValue: education.schoolName,
            onChanged: (value) {
              education.schoolName = value;
            },
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
              labelText: 'School/University',
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
            initialValue: education.degree,
            onChanged: (value) {
              education.degree = value;
            },
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
              labelText: 'Degree',
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
            initialValue: education.field,
            onChanged: (value) {
              education.field = value;
            },
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
              labelText: 'Field',
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
            initialValue: education.grade,
            onChanged: (value) {
              education.grade = value;
            },
            validator: (value) {
              print("value $value");
              var valueString = value as String;
              if (valueString.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
            // ignore: deprecated_member_use
            scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
            decoration: const InputDecoration(
              labelText: 'Grade',
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
            controller: startEducationController,
            readOnly: true,
            // ignore: deprecated_member_use
            scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
            decoration: const InputDecoration(
              labelText: "Start Date",
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
                education.startDate = formattedDate;
                setState(() {
                  startEducationController.text =
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
            controller: endEducationController,
            readOnly: true,
            // ignore: deprecated_member_use
            scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
            decoration: const InputDecoration(
              labelText: "End Date",
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
                education.endDate = formattedDate;
                setState(() {
                  endEducationController.text =
                      formattedDate; //set foratted date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: ElevatedButton(
            onPressed: () {
              String alertData = "";
              if (education.schoolName.isEmpty) {
                alertData = "Please enter school name";
              } else if (education.field.isEmpty) {
                alertData = "Please enter field";
              } else if (education.grade.isEmpty) {
                alertData = "Please enter grade";
              } else if (education.startDate.isEmpty) {
                alertData = "Please enter start date";
              } else if (education.endDate.isEmpty) {
                alertData = "Please enter end date";
              } else if (education.degree.isEmpty) {
                alertData = "Please enter degree";
              }

              if (!alertData.isEmpty) {
                Widget okButton = TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                );
                AlertDialog alert = AlertDialog(
                  title: const Text("Error"),
                  content: Text(alertData),
                  actions: [okButton],
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    });
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 1.15, 25),
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
    );
  }

  Widget basicProfileWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Are you Fresher?",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  Checkbox(
                      value: profileData.isFresher,
                      onChanged: (value) {
                        setState(() {
                          profileData.isFresher = value ?? false;
                        });
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: "",
                onChanged: (value) {
                  profileData.heading = value;
                },
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
                onChanged: (value) {
                  profileData.yourBio = value;
                },
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
          ],
        ));
  }

  Widget basic2InformationWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Gender",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSegmentedControl<int>(
                          groupValue: profileData.gender == Gender.male ? 0 : 1,
                          children: const {0: Text("Male"), 1: Text("Female")},
                          onValueChanged: (groupValue) {
                            setState(() {
                              if (groupValue == 0) {
                                profileData.gender = Gender.male;
                              } else {
                                profileData.gender = Gender.female;
                              }
                            });
                          }),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: dateOfBirthController,
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
                    profileData.dateOfBirth = formattedDate;
                    setState(() {
                      dateOfBirthController.text =
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
                onChanged: (value) {
                  profileData.phoneNumber = value;
                },
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
            if (!profileData.isFresher)
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
          ],
        ));
  }

  Widget basicInformationWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: "",
                onChanged: (value) {
                  profileData.name = value;
                },
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
                onChanged: (value) {
                  profileData.email = value;
                },
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
            )
          ],
        ));
  }

  Widget getExperienceWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(title: const Text("Add experience"), children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: null,
            initialValue: company.title,
            onChanged: (value) {
              company.title = value;
            },
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
            initialValue: company.company,
            onChanged: (value) {
              company.company = value;
            },
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
            initialValue: company.location,
            onChanged: (value) {
              company.location = value;
            },
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
          child: TextFormField(
            maxLines: null,
            initialValue: company.description,
            onChanged: (value) {
              company.description = value;
            },
            validator: (value) {
              print("value $value");
              var valueString = value as String;
              if (valueString.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
            // ignore: deprecated_member_use
            scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
            decoration: const InputDecoration(
              labelText: 'Description',
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
            controller: startDateExperience,
            readOnly: true,
            // ignore: deprecated_member_use
            scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
            decoration: const InputDecoration(
              labelText: "Start Date",
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
                company.startDate = formattedDate;
                setState(() {
                  startDateExperience.text =
                      formattedDate; //set foratted date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        if (!company.isCurrentCompany)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: endDateExperience,
              readOnly: true,
              // ignore: deprecated_member_use
              scrollPadding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
              decoration: const InputDecoration(
                labelText: "End Date",
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
                  company.endDate = formattedDate;
                  setState(() {
                    endDateExperience.text =
                        formattedDate; //set foratted date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Is this your current employer?",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              Checkbox(
                  value: company.isCurrentCompany,
                  onChanged: (value) {
                    setState(() {
                      company.isCurrentCompany = value ?? false;
                    });
                  })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: ElevatedButton(
            onPressed: () {
              String alertData = "";
              if (company.title.isEmpty) {
                alertData = "Please enter title";
              } else if (company.company.isEmpty) {
                alertData = "Please enter company";
              } else if (company.location.isEmpty) {
                alertData = "Please enter location";
              } else if (company.description.isEmpty) {
                alertData = "Please enter description";
              } else if (company.startDate.isEmpty) {
                alertData = "Please enter start date";
              } else if (company.endDate.isEmpty && !company.isCurrentCompany) {
                alertData = "Please enter end date";
              }

              if (!alertData.isEmpty) {
                Widget okButton = TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                );
                AlertDialog alert = AlertDialog(
                  title: const Text("Error"),
                  content: Text(alertData),
                  actions: [okButton],
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    });
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 1.15, 25),
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
    );
  }
}
