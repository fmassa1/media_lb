class Crew {
  final int id;
  final int gender;
  final String name;
  final String? imagePath;
  final String creditId;
  final String department;
  final String job;
  final String knowForDepartment;


  Crew({
    required this.id,
    required this.gender,
    required this.name,
    this.imagePath,
    required this.creditId,
    required this.department,
    required this.job,
    required this.knowForDepartment,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'],
      gender: json['gender'] ?? '',
      name: (json['name']),
      imagePath: json['profile_path'],
      creditId: json['credit_id'] ?? '',
      department: json['department'] ?? '',
      job: json['job'] ?? json['character'] ?? '',
      knowForDepartment: json['know_for_department'] ?? '',
    );
  }
}
