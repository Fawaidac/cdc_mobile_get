class QuestionnaireCheck {
  int id;
  String userId;
  int identitasSection;
  int mainSection;
  int furtheStudySection;
  int competentLevelSection;
  int studyMethodSection;
  int jobsStreetSection;
  int howFindJobsSection;
  int companyAppliedSection;
  int jobSuitabilitySection;
  DateTime createdAt;
  DateTime updatedAt;

  QuestionnaireCheck({
    required this.id,
    required this.userId,
    required this.identitasSection,
    required this.mainSection,
    required this.furtheStudySection,
    required this.competentLevelSection,
    required this.studyMethodSection,
    required this.jobsStreetSection,
    required this.howFindJobsSection,
    required this.companyAppliedSection,
    required this.jobSuitabilitySection,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionnaireCheck.fromJson(Map<String, dynamic> json) {
    return QuestionnaireCheck(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? "",
      identitasSection: json['identitas_section'] ?? 0,
      mainSection: json['main_section'] ?? 0,
      furtheStudySection: json['furthe_study_section'] ?? 0,
      competentLevelSection: json['competent_level_section'] ?? 0,
      studyMethodSection: json['study_method_section'] ?? 0,
      jobsStreetSection: json['jobs_street_section'] ?? 0,
      howFindJobsSection: json['how_find_jobs_section'] ?? 0,
      companyAppliedSection: json['company_applied_section'] ?? 0,
      jobSuitabilitySection: json['job_suitability_section'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(0),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime(0),
    );
  }
}
