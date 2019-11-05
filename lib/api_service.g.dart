// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['refresh'] as String,
    json['access'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    id: json['id'] as int,
    name: json['name'] as String,
    student_id: json['student_id'] as int,
    address: json['address'] as String,
    course: json['course'] as int,
    contact: json['contact'] as String,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'student_id': instance.student_id,
      'address': instance.address,
      'course': instance.course,
      'contact': instance.contact,
    };

StudentWithCourse _$StudentWithCourseFromJson(Map<String, dynamic> json) {
  return StudentWithCourse(
    id: json['id'] as int,
    name: json['name'] as String,
    student_id: json['student_id'] as int,
    address: json['address'] as String,
    course: json['course'] == null
        ? null
        : Course.fromJson(json['course'] as Map<String, dynamic>),
    contact: json['contact'] as String,
  );
}

Map<String, dynamic> _$StudentWithCourseToJson(StudentWithCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'student_id': instance.student_id,
      'address': instance.address,
      'course': instance.course,
      'contact': instance.contact,
    };

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    id: json['id'] as int,
    code: json['code'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
    _dio.options.baseUrl = 'http://192.168.254.103:8000/api';
  }

  final Dio _dio;

  @override
  getStudents() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    const _data = null;
    final _result = await _dio.request('/studentlist',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = (_result.data as List)
        .map((i) => StudentWithCourse.fromJson(i))
        .toList();
    return Future.value(value);
  }

  @override
  getToken(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = user;
    final _result = await _dio.request('/token/',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'POST', headers: {}, extra: _extra),
        data: _data);
    var value = Token.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getStudentByStudentId(studentid) async {
    ArgumentError.checkNotNull(studentid, 'studentid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    const _data = null;
    final _result = await _dio.request('/students/student_id/$studentid',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = Student.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  createPost(student) async {
    ArgumentError.checkNotNull(student, 'student');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = student;
    final _result = await _dio.request('/students/',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'POST', headers: {}, extra: _extra),
        data: _data);
    var value = Student.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getStudent(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    const _data = null;
    final _result = await _dio.request('/students/$id',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = Student.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updateStudent(id, student) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(student, 'student');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = student;
    final _result = await _dio.request('/students/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'PUT', headers: {}, extra: _extra),
        data: _data);
    var value = Student.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  deleteStudent(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    const _data = null;
    final _result = await _dio.request('/students/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'DELETE', headers: {}, extra: _extra),
        data: _data);
    var value = Student.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCourses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    const _data = null;
    final _result = await _dio.request('/courses/',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = (_result.data as List).map((i) => Course.fromJson(i)).toList();
    return Future.value(value);
  }
}
