class Enroll {
  final String grade;
  final int studentId;
  final int courseId;

  Enroll(
      {required this.grade, required this.studentId, required this.courseId});

  Map<String, dynamic> toMap() {
    return {
      'grade': grade,
      'student_id': studentId,
      'course_id': courseId,
    };
  }

  factory Enroll.fromMap(Map<String, dynamic> map) {
    return Enroll(
      grade: map['grade'],
      studentId: map['student_id'],
      courseId: map['course_id'],
    );
  }
}
