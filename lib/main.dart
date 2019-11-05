
import 'package:api_app/pages/home.dart';
import 'package:api_app/pages/login_page.dart';
import 'package:api_app/provider/widget_bloc_provider.dart';
import 'package:api_app/util/auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'blocs/app_bloc.dart';
final logger = Logger();

AuthService appAuth = new AuthService();
void main() async {
  Widget _homepage= LoginPage();
    bool _result = await appAuth.login();
    print(_result);
  if (_result) {
    _homepage = MyHomePage(title: 'Home');
  }


  runApp(
    BlocProvider(
          bloc: MyAppBloc(),
          child:MaterialApp(
        title: 'Student App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home:  _homepage,
        routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => MyHomePage(title: 'Home'),
      '/login': (BuildContext context) => LoginPage()
    },
  ))
  );
 
}




