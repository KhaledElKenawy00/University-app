class HeadOfDepartment {
  final int? headId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final int? departmentId;
  final DateTime startDate;
  final String password;

  HeadOfDepartment({
    this.headId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.departmentId,
    required this.startDate,
    required this.password,
  });

  // Convert a HeadOfDepartment object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'head_id': headId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'department_id': departmentId,
      'start_date': startDate.toIso8601String(),
      'password': password,
    };
  }

  // Create a HeadOfDepartment object from a Map (e.g., from the database)
  factory HeadOfDepartment.fromMap(Map<String, dynamic> map) {
    return HeadOfDepartment(
      headId: map['head_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      departmentId: map['department_id'],
      startDate: DateTime.parse(map['start_date']),
      password: map['password'],
    );
  }
}
