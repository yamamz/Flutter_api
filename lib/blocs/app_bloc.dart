import 'dart:async';
import 'package:api_app/main.dart';
import 'package:api_app/pages/login_page.dart';
import 'package:api_app/provider/widget_bloc_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';

class MyAppBloc implements BlocBase {
  List<StudentWithCourse> students;
  List<Course> courses;
  final _dio = Dio();
  RestClient client;
  StreamController<List<StudentWithCourse>> _studentListController =
      StreamController<List<StudentWithCourse>>.broadcast();
  Sink<List<StudentWithCourse>> get _inStudentList =>
      _studentListController.sink;
  Stream<List<StudentWithCourse>> get outStudentList =>
      _studentListController.stream;

  StreamController<List<Course>> _courseListController =
      StreamController<List<Course>>.broadcast();
  Sink<List<Course>> get _inCourseList => _courseListController.sink;
  Stream<List<Course>> get outCourseList => _courseListController.stream;

  MyAppBloc() {
    print("pass here");
    _initDio();
   initStudents();
    initCourses();
  }
  void _initDio() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    _dio.options.headers = {
      'Authorization': 'Bearer ' + token,
    };
       _dio.options.headers["Content-Type"] =
        "application/json";
         client = RestClient(_dio);
  }

  @override
  void dispose() {
    _studentListController.close();
    _courseListController.close();
  }

  void initStudents() async {
        
  // Provide a dio instance
  try{
  students = await client.getStudents();
  _inStudentList.add(students);

  }catch(obj){
    logger.e(obj.toString());
  }





  }

  void initCourses() async {
    print('pass here course');
    
    courses = await client.getCourses();
    
    _inCourseList.add(courses);
  }

  void addStudent(Student student) {
    try{
client.createPost(student);
    Course course = courses.firstWhere((c) => c.id == student.course);
    students.add(StudentWithCourse(
        course: course,
        name: student.name,
        address: student.address,
        student_id: student.student_id));
    _inStudentList.add(students);
    } catch(obj){
      switch (obj.runtimeType) {
      case DioError:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioError).response;
        logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
    }
    }
    
  }

  void updateStudent(Student student) {
    client.updateStudent(student.id, student);
    int index = students.indexWhere((s) => s.id == student.id);
    Course course = courses.firstWhere((c) => c.id == student.course);
    //students.add(StudentWithCourse(course: course, name: student.name, address: student.address, student_id: student.student_id));
    students[index].address = student.address;
    students[index].name = student.name;
    students[index].course = course;
    students[index].student_id = student.student_id;
    _inStudentList.add(students);
  }

  void deleteStudent(int id, int index) {
    client.deleteStudent(id);
    students.removeAt(index);
    _inStudentList.add(students);
  }
}
