import '../api_service.dart';
import 'package:dio/dio.dart';

class Api {
  final _dio = Dio();
  RestClient client;

  Api(){
    _dio.options.headers["Content-Type"] = "application/json";
    client = RestClient(_dio);
  }

  Future<Student> getStudentbyId(int studentid){
    return client.getStudentByStudentId(studentid);
  }

  Future<List<StudentWithCourse>> getStudents() async{
    return await client.getStudents();
  }

  Future<List<Course>> getCourses() async{
    return await client.getCourses();
  }
  Future<Student> createStudent(Student student) async {
    return await client.createPost(student);
  }
}
