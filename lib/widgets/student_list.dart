import 'package:api_app/blocs/app_bloc.dart';

import 'package:api_app/pages/add_student.dart';

import 'package:api_app/provider/widget_bloc_provider.dart';
import 'package:api_app/widgets/student_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../api_service.dart';

class StudentList extends StatefulWidget {
  StudentList({Key key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
 MyAppBloc studentBloc; 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
    print("init state");

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // studentBloc.dispose();
    print("na dispose");
  }


  @override
  Widget build(BuildContext context) {
  studentBloc = BlocProvider.of<MyAppBloc>(context);
  studentBloc.initStudents();
  print('build');
    return Padding(
        padding: EdgeInsets.only(top: 4, left: 4, right: 4),
        child: Center(
            child: StreamBuilder<List<StudentWithCourse>>(
          stream: studentBloc.outStudentList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Text("No Student Added");
              }

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.15,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: "delete",
                          foregroundColor: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            studentBloc.deleteStudent(
                                snapshot.data[index].id, index);
                            _showMessageDelete(context);
                          },
                        ),
                        IconSlideAction(
                          caption: 'edit',
                          foregroundColor: Colors.greenAccent,
                          icon: Icons.edit,
                          onTap: () {
                            var st = Student(
                                id: snapshot.data[index].id,
                                name: snapshot.data[index].name,
                                address: snapshot.data[index].address,
                                course: snapshot.data[index].course.id,
                                student_id: snapshot.data[index].student_id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddStudent(
                                        student: st,
                                      )),
                            );
                          },
                        ),
                      ],
                      child: StudentItem(
                        student: snapshot.data[index],
                      ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )),
      );
  }

  void _showMessageDelete(BuildContext context) {
  final snackBar = SnackBar(content: Text('Success fully deleted!'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
  Scaffold.of(context).showSnackBar(snackBar);
}
}