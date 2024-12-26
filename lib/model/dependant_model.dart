class Dependent {
  final String nameDependent;
  final String? relation;
  final DateTime? birthDate;
  final String? gender;
  final int? profId;

  Dependent(
      {required this.nameDependent,
      this.relation,
      this.birthDate,
      this.gender,
      this.profId});

  Map<String, dynamic> toMap() {
    return {
      'name_dependent': nameDependent,
      'relation': relation,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender,
      'prof_id': profId,
    };
  }

  factory Dependent.fromMap(Map<String, dynamic> map) {
    return Dependent(
      nameDependent: map['name_dependent'],
      relation: map['relation'],
      birthDate:
          map['birth_date'] != null ? DateTime.parse(map['birth_date']) : null,
      gender: map['gender'],
      profId: map['prof_id'],
    );
  }
}
