class Professor {
  final int? profId;
  final String email;
  final String password;
  final String? fName;
  final String? lName;
  final int? departmentId;

  Professor({
    this.profId,
    required this.email,
    required this.password,
    this.fName,
    this.lName,
    this.departmentId,
  });

  // Convert a Professor object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'prof_id': profId,
      'email': email,
      'password': password,
      'f_name': fName,
      'l_name': lName,
      'department_id': departmentId,
    };
  }

  // Create a Professor object from a Map (e.g., from the database)
  factory Professor.fromMap(Map<String, dynamic> map) {
    return Professor(
      profId: map['prof_id'],
      email: map['email'],
      password: map['password'],
      fName: map['f_name'],
      lName: map['l_name'],
      departmentId: map['department_id'],
    );
  }
}
