
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_service.g.dart';


@RestApi(baseUrl: "http://192.168.254.103:8000/api")
//flutter pub run build_runner build
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/studentlist")
  Future<List<StudentWithCourse>> getStudents();
  
  @POST("/token/")
  Future<Token> getToken(@Body() User user);

  @GET("/students/student_id/{studentid}")
  Future<Student> getStudentByStudentId(@Path("studentid") int studentid);

  @POST("/students/")
  Future<Student> createPost(@Body() Student student);

  @GET("/students/{id}")
  Future<Student> getStudent(@Path("id") int id);

  
  @PUT("/students/{id}/")
  Future<Student> updateStudent(@Path("id") int id,@Body() Student student);

  @DELETE("/students/{id}/")
  Future<Student> deleteStudent(@Path("id") int id);

  @GET("/courses/")
  Future<List<Course>> getCourses();
  
}
@JsonSerializable()
class Token{
  String refresh;
  String access;
  Token(this.refresh,this.access);
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);

}

@JsonSerializable()
class User{
  String username;
  String password;
  User({this.username,this.password});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}

@JsonSerializable()
class Student { 
  int id;
  String name;
  int student_id;
  String address;
  int course;
  String contact;
  Student({this.id,this.name, this.student_id, this.address, this.course,this.contact});

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
@JsonSerializable()
class StudentWithCourse{
  int id;
  String name;
  int student_id;
  String address;
  Course course;
  String contact;
  StudentWithCourse({this.id,this.name, this.student_id, this.address, this.course, this.contact});

  factory StudentWithCourse.fromJson(Map<String, dynamic> json) => _$StudentWithCourseFromJson(json);
  Map<String, dynamic> toJson() => _$StudentWithCourseToJson(this);
}

@JsonSerializable()
class Course{
  int id;
  String code;
  String description;
  Course({this.id,this.code,this.description});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}