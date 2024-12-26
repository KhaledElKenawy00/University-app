import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class StudentPage extends StatefulWidget {
  final String email; // The student's email to fetch details for

  const StudentPage({required this.email});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Future<Map<String, dynamic>?> studentDetails;
  late Future<List<Map<String, dynamic>>> allCourses;

  @override
  void initState() {
    super.initState();
    // Fetch student details based on the email passed
    studentDetails = DatabaseHelper.instance.getStudentByEmail(widget.email);
    // Fetch all courses
    allCourses = DatabaseHelper.instance.getAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Student Details Section
            FutureBuilder<Map<String, dynamic>?>(
              future: studentDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                }

                if (!snapshot.hasData) {
                  return Center(
                      child: Text('Student not found')); // No data state
                }

                final student = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First Name: ${student['first_name']}',
                          style: TextStyle(fontSize: 18)),
                      Text('Last Name: ${student['last_name']}',
                          style: TextStyle(fontSize: 18)),
                      Text('Email: ${student['email']}',
                          style: TextStyle(fontSize: 18)),
                      Text('Phone: ${student['phone']}',
                          style: TextStyle(fontSize: 18)),
                      Text('Department ID: ${student['department_id']}',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                );
              },
            ),

            // All Courses Section
            FutureBuilder<List<Map<String, dynamic>>>(
              future: allCourses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No courses available')); // No courses found
                }

                final courses = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Courses:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling for this section
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(course['course_name']),
                              subtitle:
                                  Text('Course ID: ${course['course_id']}'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
