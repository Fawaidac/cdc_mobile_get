import 'dart:convert';

JurusanModel jurusanModelFromJson(String str) =>
    JurusanModel.fromJson(json.decode(str));

String jurusanModelToJson(JurusanModel data) => json.encode(data.toJson());

class JurusanModel {
  List<Datum> data;
  String message;
  int code;
  bool status;

  JurusanModel({
    required this.data,
    required this.message,
    required this.code,
    required this.status,
  });

  factory JurusanModel.fromJson(Map<String, dynamic> json) => JurusanModel(
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
  String namaJurusan;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaJurusan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaJurusan: json["nama_jurusan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jurusan": namaJurusan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
