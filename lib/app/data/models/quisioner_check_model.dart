class QuestionnaireCheck {
  String? id;
  String? userId;
  String? level;
  String? identitasSection;
  String? mainSection;
  String? furtheStudySection;
  String? competentLevelSection;
  String? studyMethodSection;
  String? jobsStreetSection;
  String? howFindJobsSection;
  String? companyAppliedSection;
  String? jobSuitabilitySection;
  String? expired;
  String? createdAt;
  String? updatedAt;

  QuestionnaireCheck(
      {this.id,
      this.userId,
      this.level,
      this.identitasSection,
      this.mainSection,
      this.furtheStudySection,
      this.competentLevelSection,
      this.studyMethodSection,
      this.jobsStreetSection,
      this.howFindJobsSection,
      this.companyAppliedSection,
      this.jobSuitabilitySection,
      this.expired,
      this.createdAt,
      this.updatedAt});

  QuestionnaireCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    level = json['level'];
    identitasSection = json['identitas_section'];
    mainSection = json['main_section'];
    furtheStudySection = json['furthe_study_section'];
    competentLevelSection = json['competent_level_section'];
    studyMethodSection = json['study_method_section'];
    jobsStreetSection = json['jobs_street_section'];
    howFindJobsSection = json['how_find_jobs_section'];
    companyAppliedSection = json['company_applied_section'];
    jobSuitabilitySection = json['job_suitability_section'];
    expired = json['expired'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['level'] = this.level;
    data['identitas_section'] = this.identitasSection;
    data['main_section'] = this.mainSection;
    data['furthe_study_section'] = this.furtheStudySection;
    data['competent_level_section'] = this.competentLevelSection;
    data['study_method_section'] = this.studyMethodSection;
    data['jobs_street_section'] = this.jobsStreetSection;
    data['how_find_jobs_section'] = this.howFindJobsSection;
    data['company_applied_section'] = this.companyAppliedSection;
    data['job_suitability_section'] = this.jobSuitabilitySection;
    data['expired'] = this.expired;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
