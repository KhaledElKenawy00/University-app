import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'university.db');

    print("+++++++++++++++++++$path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Departments (
        department_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        building TEXT
      )
    ''');

    await db.execute('''

 CREATE TABLE HeadOfDepartment (
        head_id INTEGER PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        first_name TEXT,
        last_name TEXT,
        phone INTEGER,
        department_id INTEGER,
        FOREIGN KEY (department_id) REFERENCES Departments (department_id)
      )
''');
    await db.execute('''
      CREATE TABLE Student (
        student_id INTEGER PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        first_name TEXT,
        last_name TEXT,
        phone INTEGER,
        department_id INTEGER,
        FOREIGN KEY (department_id) REFERENCES Departments (department_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Professor (
        professor_id INTEGER PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        first_name TEXT,
        last_name TEXT,
        phone INTEGER,
        department_id INTEGER,
        FOREIGN KEY (department_id) REFERENCES Departments (department_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Course (
        course_id INTEGER PRIMARY KEY,
        course_name TEXT,
        semester TEXT,
        department_id INTEGER,
        prof_id INTEGER,
        FOREIGN KEY (department_id) REFERENCES Departments (department_id),
        FOREIGN KEY (prof_id) REFERENCES Professor (prof_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Dependents (
        name_dependent TEXT,
        relation TEXT,
        birth_date DATE,
        gender TEXT,
        prof_id INTEGER,
        FOREIGN KEY (prof_id) REFERENCES Professor (prof_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Enroll (
        grade TEXT,
        student_id INTEGER,
        course_id INTEGER,
        PRIMARY KEY (student_id, course_id),
        FOREIGN KEY (student_id) REFERENCES Student (student_id),
        FOREIGN KEY (course_id) REFERENCES Course (course_id)
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final db = await instance.database;
    var res = await db.query('Student');
    return res;
  }

  // Get all available courses
  Future<List<Map<String, dynamic>>> getAllCourses() async {
    final db = await instance.database;
    var res = await db.query('Course');
    return res;
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data, String where,
      List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
      String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // Function to query by email and password
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;

    // Query the Student table
    List<Map<String, dynamic>> studentResult = await db.query(
      'Student',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Query the Professor table
    List<Map<String, dynamic>> professorResult = await db.query(
      'Professor',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Query the HeadOfDepartment table
    List<Map<String, dynamic>> headOfDepartmentResult = await db.query(
      'HeadOfDepartment',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Check which table the user exists in
    if (studentResult.isNotEmpty) {
      return {'userType': 'Student', 'data': studentResult.first};
    } else if (professorResult.isNotEmpty) {
      return {'userType': 'Professor', 'data': professorResult.first};
    } else if (headOfDepartmentResult.isNotEmpty) {
      return {
        'userType': 'HeadOfDepartment',
        'data': headOfDepartmentResult.first
      };
    }

    return null; // No match found
  }

  Future<void> addGrade(int studentId, int courseId, String grade) async {
    final db = await instance.database;

    // Check if a grade already exists for the student and course
    var result = await db.rawQuery('''
      SELECT * FROM Enroll WHERE student_id = ? AND course_id = ?
    ''', [studentId, courseId]);

    if (result.isNotEmpty) {
      // If a grade already exists, update it
      await db.update(
        'Enroll',
        {'grade': grade},
        where: 'student_id = ? AND course_id = ?',
        whereArgs: [studentId, courseId],
      );
    } else {
      // If no grade exists, insert a new record
      await db.insert('Enroll', {
        'student_id': studentId,
        'course_id': courseId,
        'grade': grade,
      });
    }
  }

  Future<Map<String, dynamic>?> getStudentByEmail(String email) async {
    final db = await instance.database;

    var res = await db.query(
      'Student', // Table name
      where: 'email = ?', // Query condition
      whereArgs: [email], // Query argument
    );

    if (res.isNotEmpty) {
      return res.first; // Return the first result, which is the student data
    }

    return null; // Return null if no student is found
  }

  Future<Map<String, dynamic>?> getUserById(int userId, String table) async {
    final db = await database;

    // Query the specified table (Student, Professor, or HeadOfDepartment) based on the ID
    var result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first; // Return the first matching record
    } else {
      return null; // No record found for the given user ID
    }
  }

  Future<List<Map<String, dynamic>>> getGradesForStudent(int studentId) async {
    final db = await database; // Get the database instance
    var res = await db.query(
      'grades',
      where: 'student_id = ?',
      whereArgs: [studentId], // Filter by student_id
    );
    return res.isNotEmpty ? res : []; // Return the grades for the student
  }

  Future<List<Map<String, dynamic>>> getStudentsInCourse(int courseId) async {
    final db = await database; // Get the database instance

    // Query grades to find students enrolled in the given course
    var res = await db.query(
      'grades',
      where: 'course_id = ?',
      whereArgs: [courseId], // Filter by course_id
    );

    // Create a list to store the students
    List<Map<String, dynamic>> students = [];

    // Fetch student details for each grade entry
    for (var grade in res) {
      var studentId = grade['student_id'];

      // Query the 'students' table to get details for each student
      var studentData = await db.query(
        'students',
        where: 'student_id = ?',
        whereArgs: [studentId],
      );

      if (studentData.isNotEmpty) {
        students.add(studentData.first); // Add the student details to the list
      }
    }

    // Return the list of students
    return students;
  }
}
