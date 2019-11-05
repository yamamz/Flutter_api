import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service.dart';
import '../main.dart';

class AuthService {
  // Login
  final _dio = Dio();
  RestClient client;
  Future<bool> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    _dio.options.headers = {
      'Authorization': 'Bearer ' + token,
    };
    _dio.options.headers["Content-Type"] = "application/json";
    client = RestClient(_dio);

    try{
      await client.getCourses();
      return true;
    }catch(obj){
      return false;
    }

    //return false;
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(new Duration(seconds: 1));
  }
}
