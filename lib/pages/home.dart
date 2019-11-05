import 'dart:async';

import 'package:api_app/blocs/app_bloc.dart';
import 'package:api_app/pages/add_student.dart';
import 'package:api_app/pages/scan_qr.dart';
import 'package:api_app/provider/widget_bloc_provider.dart';
import 'package:api_app/widgets/student_list.dart';
import 'package:api_app/widgets/student_list_tile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller;
  int demoIndex = 0;
  String token = "";
  final List<Widget> contents = [StudentList(), ScanQr()];
  @override
  void initState() {
    super.initState();
    _getRootUrl();


    
  }

  _getRootUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = prefs.getString('url') ?? "192.168.254.103";
    _controller = new TextEditingController(text: url);
  }

 
  _addRootUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setString('url', url);
    String urls = prefs.getString('url') ?? "192.168.254.103";
    setState(() {
//  _url = urls;
      print(urls);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.INFO,
                  body: Center(
                      child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "Enter root url",
                      ),
                    ),
                  )),
                  // tittle: 'This is Ignored',
                  // desc:   'This is also Ignored',
                  btnOkOnPress: () {
                    _addRootUrl(_controller.text);
                  },
                ).show();
              },
              child: Icon(Icons.settings)),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddStudent()),
                  );
                },
                child: Icon(Icons.add)),
          )
        ],
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
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
      body: contents[demoIndex],
      bottomNavigationBar: ExpandingBottomBar(
        navBarHeight: 70.0,
        items: [
          ExpandingBottomBarItem(
            icon: Icons.bookmark_border,
            text: "Students",
            selectedColor: Colors.purple,
          ),
          ExpandingBottomBarItem(
            icon: Icons.code,
            text: "Qr code",
            selectedColor: Colors.pink,
          ),
        ],
        selectedIndex: demoIndex,
        onIndexChanged: (demo) {
          setState(() {
            demoIndex = demo;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
