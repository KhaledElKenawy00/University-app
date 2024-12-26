import 'package:flutter/material.dart';
import 'package:university/service/datbase_helper.dart';

class ShowAllStudentsScreen extends StatefulWidget {
  @override
  _ShowAllStudentsScreenState createState() => _ShowAllStudentsScreenState();
}

class _ShowAllStudentsScreenState extends State<ShowAllStudentsScreen> {
  late Future<List<Map<String, dynamic>>> _students;

  @override
  void initState() {
    super.initState();
    _students = _fetchStudents();
  }

  // Fetch all students from the database
  Future<List<Map<String, dynamic>>> _fetchStudents() async {
    final db = DatabaseHelper.instance;
    return await db.queryAll('student'); // Query the 'student' table
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students available.'));
          }

          // Display the students in a ListView
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListTile(
                  title:
                      Text('${student['first_name']} ${student['last_name']}'),
                  subtitle: Text('Email: ${student['email']}'),
                  onTap: () {
                    // You can add logic here to view details of the student if needed
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
