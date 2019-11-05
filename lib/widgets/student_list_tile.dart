


import 'package:flutter/material.dart';
import '../api_service.dart';

class StudentItem extends StatelessWidget {
  final StudentWithCourse student;
  StudentItem({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: InkWell(
        splashColor: Colors.pinkAccent,
        onTap: () {
          print('Hello');
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
  
              children: <Widget>[
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: getColorByinitial(student.name.substring(0,1)),
                    child: Text(student.name.substring(0,1),style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        student.course != null?
                        "${student.course.code}-${student.name}":student.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(student.address,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ))
                    ],
                  ),
                ),
  
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColorByinitial(String initial){
    print(initial.codeUnitAt(0).toInt());
    if(initial.codeUnitAt(0) >= 65 && initial.codeUnitAt(0) <= 70 || initial.codeUnitAt(0) >= 97 && initial.codeUnitAt(0) <= 101){
      return Colors.yellow;
    }
    else if(initial.codeUnitAt(0) >= 71 && initial.codeUnitAt(0) <= 75 || initial.codeUnitAt(0) >= 102 && initial.codeUnitAt(0) <= 106){
      return Colors.green;
    }
    else if(initial.codeUnitAt(0) >= 76 && initial.codeUnitAt(0) <= 81 || initial.codeUnitAt(0) >= 107 && initial.codeUnitAt(0) <= 111){
      return Colors.blueAccent;
    }
    else if(initial.codeUnitAt(0) >= 82 && initial.codeUnitAt(0) <= 86 || initial.codeUnitAt(0) >= 112 && initial.codeUnitAt(0) <= 116){
      return Colors.purple;
    }
    else if(initial.codeUnitAt(0) >= 87 && initial.codeUnitAt(0) <= 90 || initial.codeUnitAt(0) >= 117 && initial.codeUnitAt(0) <= 122){
      return Colors.cyanAccent;
    }
    print("ni agi dri");
   return Colors.amberAccent;
  }

}
