import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class CourseDetailPage extends StatefulWidget {
  final int courseId;

  const CourseDetailPage({required this.courseId});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Future<List<Map<String, dynamic>>> studentsInCourse;

  @override
  void initState() {
    super.initState();
    // Fetch students enrolled in this course from the database
    studentsInCourse =
        DatabaseHelper.instance.getStudentsInCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Details')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: studentsInCourse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students enrolled in this course'));
          }

          var students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var student = students[index];
              return ListTile(
                title: Text('${student['first_name']} ${student['last_name']}'),
                subtitle: Text('Email: ${student['email']}'),
                trailing: Text('Grade: ${student['grade'] ?? 'N/A'}'),
              );
            },
          );
        },
      ),
    );
  }
}
