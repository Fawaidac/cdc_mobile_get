class JobsModel {
  String? id;
  String? userId;
  String? perusahaan;
  String? jabatan;
  int? gaji;
  String? jenisPekerjaan;
  String? tahunMasuk;
  String? tahunKeluar;
  int? pekerjaanSaatini;
  String? createdAt;
  String? updatedAt;

  JobsModel(
      {this.id,
      this.userId,
      this.perusahaan,
      this.jabatan,
      this.gaji,
      this.jenisPekerjaan,
      this.tahunMasuk,
      this.tahunKeluar,
      this.pekerjaanSaatini,
      this.createdAt,
      this.updatedAt});

  JobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    perusahaan = json['perusahaan'];
    jabatan = json['jabatan'];
    gaji = json['gaji'];
    jenisPekerjaan = json['jenis_pekerjaan'];
    tahunMasuk = json['tahun_masuk'];
    tahunKeluar = json['tahun_keluar'];
    pekerjaanSaatini = json['pekerjaan_saatini'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class JobsListModel {
  List<JobsModel>? jobs;

  JobsListModel({this.jobs});

  JobsListModel.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs!.add(JobsModel.fromJson(v));
      });
    }
  }
}
