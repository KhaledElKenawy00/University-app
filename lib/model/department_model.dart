class Department {
  final int departmentId;
  final String name;
  final String? building;

  Department({required this.departmentId, required this.name, this.building});

  // Convert a Department into a Map
  Map<String, dynamic> toMap() {
    return {
      'department_id': departmentId,
      'name': name,
      'building': building,
    };
  }

  // Create a Department from a Map
  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      departmentId: map['department_id'],
      name: map['name'],
      building: map['building'],
    );
  }
}
