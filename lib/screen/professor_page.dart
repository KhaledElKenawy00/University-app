import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  late Future<List<Map<String, dynamic>>> allStudents;
  late Future<List<Map<String, dynamic>>> allCourses;
  int? selectedCourseId; // The selected course id for grade input

  @override
  void initState() {
    super.initState();
    // Fetch all students and courses from the database
    allStudents = DatabaseHelper.instance.getAllStudents();
    allCourses = DatabaseHelper.instance.getAllCourses();
  }

  // Function to show the grade input dialog with course selection
  Future<void> _showGradeDialog(int studentId) async {
    final gradeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Grade for Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown to select course
              FutureBuilder<List<Map<String, dynamic>>>(
                future: allCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No courses available');
                  }

                  var courses = snapshot.data!;
                  return DropdownButton<int>(
                    value: selectedCourseId,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCourseId = newValue;
                      });
                    },
                    hint: Text('Select Course'),
                    items: courses.map((course) {
                      return DropdownMenuItem<int>(
                        value: course['course_id'],
                        child: Text(course['course_name']),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 10),
              // Grade Input
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: 'Grade'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final grade = gradeController.text.trim();
                if (selectedCourseId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a course')),
                  );
                  return;
                }
                if (grade.isNotEmpty) {
                  // Add the grade to the selected course
                  await DatabaseHelper.instance
                      .addGrade(studentId, selectedCourseId!, grade);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Grade added successfully')),
                  );
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a grade')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students & Courses'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display All Students
            Text(
              'Students:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: allStudents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No students found'));
                }

                var students = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];
                    return ListTile(
                      title: Text(
                          '${student['first_name']} ${student['last_name']}'),
                      subtitle: Text('Email: ${student['email']}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Show the grade input dialog for this student
                          _showGradeDialog(student['student_id']);
                        },
                        child: Text('Add Grade'),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            // Display Available Courses
            Text(
              'Available Courses:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: allCourses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No courses available'));
                }

                var courses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    var course = courses[index];
                    return ListTile(
                      title: Text(course['course_name']),
                      subtitle:
                          Text('Department ID: ${course['department_id']}'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
