import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart'; // Ensure you have the DatabaseHelper imported

class AddNewCoursePage extends StatefulWidget {
  @override
  _AddNewCoursePageState createState() => _AddNewCoursePageState();
}

class _AddNewCoursePageState extends State<AddNewCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _semesterController = TextEditingController();
  final _departmentIdController = TextEditingController();
  final _professorIdController = TextEditingController();

  Future<void> _addNewCourse() async {
    if (_formKey.currentState!.validate()) {
      try {
        final db = DatabaseHelper.instance;
        await db.insert('Course', {
          'course_name': _courseNameController.text,
          'semester': _semesterController.text,
          'department_id': int.parse(_departmentIdController.text),
          'prof_id': int.parse(_professorIdController.text),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Course Added Successfully!')),
        );

        // Clear the form after successful submission
        _courseNameController.clear();
        _semesterController.clear();
        _departmentIdController.clear();
        _professorIdController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding course: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Course'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _courseNameController,
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter course name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(
                  labelText: 'Semester',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) => value!.isEmpty ? 'Enter semester' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _departmentIdController,
                decoration: InputDecoration(
                  labelText: 'Department ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter department ID' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _professorIdController,
                decoration: InputDecoration(
                  labelText: 'Professor ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter professor ID' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNewCourse,
                child: Text('Add Course'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
