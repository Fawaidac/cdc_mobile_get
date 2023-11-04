class EducationsModel {
  String? perguruan;
  String? jurusan;
  String? strata;
  String? noIjasah;
  String? prodi;
  int? tahunMasuk;
  int? tahunLulus;
  String? id;

  EducationsModel(
      {this.perguruan,
      this.jurusan,
      this.strata,
      this.noIjasah,
      this.prodi,
      this.tahunMasuk,
      this.tahunLulus,
      this.id});

  EducationsModel.fromJson(Map<String, dynamic> json) {
    perguruan = json['perguruan'];
    jurusan = json['jurusan'];
    strata = json['strata'];
    noIjasah = json['no_ijasah'];
    prodi = json['prodi'];
    tahunMasuk = json['tahun_masuk'];
    tahunLulus = json['tahun_lulus'];
    id = json['id'];
  }
}

class EducationsListModel {
  List<EducationsModel>? educations;

  EducationsListModel({this.educations});

  EducationsListModel.fromJson(Map<String, dynamic> json) {
    if (json['educations'] != null) {
      educations = [];
      json['educations'].forEach((v) {
        educations!.add(EducationsModel.fromJson(v));
      });
    }
  }
}
