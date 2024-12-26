class Course {
  final int courseId;
  final String? courseName;
  final String? semester;
  final int? departmentId;
  final int? profId;

  Course(
      {required this.courseId,
      this.courseName,
      this.semester,
      this.departmentId,
      this.profId});

  Map<String, dynamic> toMap() {
    return {
      'course_id': courseId,
      'course_name': courseName,
      'semester': semester,
      'department_id': departmentId,
      'prof_id': profId,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['course_id'],
      courseName: map['course_name'],
      semester: map['semester'],
      departmentId: map['department_id'],
      profId: map['prof_id'],
    );
  }
}
