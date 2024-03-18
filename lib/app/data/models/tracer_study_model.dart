import 'dart:convert';

TracerStudyModel tracerStudyModelFromJson(String str) =>
    TracerStudyModel.fromJson(json.decode(str));

String tracerStudyModelToJson(TracerStudyModel data) =>
    json.encode(data.toJson());

class TracerStudyModel {
  List<Datum> data;
  String message;
  int code;
  bool status;

  TracerStudyModel({
    required this.data,
    required this.message,
    required this.code,
    required this.status,
  });

  factory TracerStudyModel.fromJson(Map<String, dynamic> json) =>
      TracerStudyModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
        "status": status,
      };
}

class Datum {
  int id;
  String judul;
  String tipe;
  int? idQuisIdentitasProdi;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.judul,
    required this.tipe,
    required this.idQuisIdentitasProdi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        judul: json["judul"],
        tipe: json["tipe"],
        idQuisIdentitasProdi: json["id_quis_identitas_prodi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "tipe": tipe,
        "id_quis_identitas_prodi": idQuisIdentitasProdi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
