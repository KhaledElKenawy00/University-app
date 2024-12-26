class Student {
  final int? studentId;
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;
  final int? phone;
  final int? departmentId;

  Student({
    this.studentId,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.departmentId,
  });

  // Convert a Student object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'student_id': studentId,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'department_id': departmentId,
    };
  }

  // Create a Student object from a Map (e.g., from the database)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['student_id'],
      email: map['email'],
      password: map['password'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      phone: map['phone'],
      departmentId: map['department_id'],
    );
  }
}
