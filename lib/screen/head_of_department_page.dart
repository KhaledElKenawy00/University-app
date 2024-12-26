import 'package:flutter/material.dart';
import 'package:university/screen/add_course.dart';
import 'package:university/screen/register_page.dart';
import 'package:university/screen/show_all_couses.dart';
import 'package:university/screen/show_all_students.dart';

class HeadOfDepartmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => RegisterScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout)),
        title: Center(
          child: Text(
            "HeadOfDepartment",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.pink),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AddNewCoursePage(),
                ),
              );
            },
            child: Center(
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(child: Text("add Course")),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ShowAllCoursesScreen(),
                ),
              );
            },
            child: Center(
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(child: Text("Show all Course")),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ShowAllStudentsScreen(),
                ),
              );
            },
            child: Center(
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(child: Text("Show all Student")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
