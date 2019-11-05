import 'package:api_app/blocs/app_bloc.dart';
import 'package:api_app/provider/widget_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  Student student;
  _AddStudentState({this.student});

  String _name;
  String _address;
  int _stId;
  int _course;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
        if (student != null) {
        _name = student.name;
        _address = student.address;
        _stId = student.student_id;
        _course = student.course;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyAppBloc studentBloc = BlocProvider.of<MyAppBloc>(context);
    return Scaffold(

       extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:  Text(student == null ? "Add Student" : "Edit Student"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.pink, Colors.redAccent],
            ),
          ),
        ),
      ),
     
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: EdgeInsets.only(
                  top: 40.0, left: 16.0, right: 16.0, bottom: 30.0),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 8.0, right: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        initialValue: _stId == null ? "" : _stId.toString(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter student ID";
                          }
                       },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Enter Student ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onSaved: (value) => _stId = int.parse(value),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        initialValue: _name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Fullname';
                          }
                        },
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Enter Fullname',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onSaved: (value) => _name = value,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        initialValue: _address,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter address";
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Enter an address',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onSaved: (value) => _address = value,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FutureBuilder<List<Course>>(
                          future: _fetchCourses(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Course>> snapshot) {
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              return DropdownButtonFormField(
                                  value: _course,
                                  hint: Text('Select Course'),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8.0),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      isDense: true),
                                  items: snapshot.data
                                      .map((course) => DropdownMenuItem<int>(
                                            child: Text(course.code),
                                            value: course.id,
                                          ))
                                      .toList(),
                                  onChanged: (int value) {
                                    setState(() => _course = value);

                                    print("id $value");
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState.save();
                            print(_name);
                            if (student != null) {
                              student.name = _name;
                              student.address = _address;
                              student.course = _course;
                              student.student_id = _stId;
                              studentBloc.updateStudent(student);
                                         Navigator.pop(context);
                            } else {
                              try {
                                final stud = Student(
                                    name: _name,
                                    address: _address,
                                    student_id: _stId,
                                    course: _course);
                                studentBloc.addStudent(stud);
                                Navigator.pop(context);
                              } catch (e) {}
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: Center(
                child: Icon(
                  Icons.account_circle,
                  size: 60.0,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Course>> _fetchCourses() async {
    final _dio = Dio();
       SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    _dio.options.headers = {
      'Authorization': 'Bearer ' + token,
    };
    RestClient restClient = RestClient(_dio);
    return await restClient.getCourses();
  }
}

class AddStudent extends StatefulWidget {
  final Student student;
  AddStudent({this.student});
  @override
  State<StatefulWidget> createState() {
    return _AddStudentState(student: student);
  }
}
