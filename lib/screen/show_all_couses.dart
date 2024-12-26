import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class ShowAllCoursesScreen extends StatefulWidget {
  @override
  _ShowAllCoursesScreenState createState() => _ShowAllCoursesScreenState();
}

class _ShowAllCoursesScreenState extends State<ShowAllCoursesScreen> {
  late Future<List<Map<String, dynamic>>> _courses;

  @override
  void initState() {
    super.initState();
    _courses = _fetchCourses();
  }

  // Fetch all courses from the database
  Future<List<Map<String, dynamic>>> _fetchCourses() async {
    final db = DatabaseHelper.instance;
    return await db.queryAll('course');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Courses'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No courses available.'));
          }

          // Display the courses in a ListView
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListTile(
                  title: Text(course['course_name']),
                  subtitle: Text(
                      'Professor ID: ${course['prof_id']}, Department ID: ${course['department_id']}'),
                  onTap: () {
                    // You can add logic here to view details of the course if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
