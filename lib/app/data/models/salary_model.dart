class UserProfile {
  final String fullname;
  final String lastPosition;
  final String highestSalary;
  final String company;

  UserProfile({
    required this.fullname,
    required this.lastPosition,
    required this.highestSalary,
    required this.company,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullname: json['fullname'],
      lastPosition: json['last_position'],
      highestSalary: json['highest_salary'],
      company: json['company'],
    );
  }
}
