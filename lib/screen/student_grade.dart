import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class StudentGradeDetailPage extends StatefulWidget {
  final int studentId;

  const StudentGradeDetailPage({required this.studentId});

  @override
  _StudentGradeDetailPageState createState() => _StudentGradeDetailPageState();
}

class _StudentGradeDetailPageState extends State<StudentGradeDetailPage> {
  late Future<List<Map<String, dynamic>>> studentGrades;

  @override
  void initState() {
    super.initState();
    // Fetch student grades from the database
    studentGrades =
        DatabaseHelper.instance.getGradesForStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Grades')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: studentGrades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No grades available'));
          }

          var grades = snapshot.data!;
          return ListView.builder(
            itemCount: grades.length,
            itemBuilder: (context, index) {
              var grade = grades[index];
              return ListTile(
                title: Text(grade['course_name']),
                subtitle: Text('Grade: ${grade['grade']}'),
              );
            },
          );
        },
      ),
    );
  }
}
