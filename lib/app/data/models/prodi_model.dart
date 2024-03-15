import 'dart:convert';

ProdiModel prodiModelFromJson(String str) =>
    ProdiModel.fromJson(json.decode(str));

String prodiModelToJson(ProdiModel data) => json.encode(data.toJson());

class ProdiModel {
  List<Datum> data;
  String message;
  int code;
  bool status;

  ProdiModel({
    required this.data,
    required this.message,
    required this.code,
    required this.status,
  });

  factory ProdiModel.fromJson(Map<String, dynamic> json) => ProdiModel(
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
  String namaProdi;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaProdi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaProdi: json["nama_prodi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_prodi": namaProdi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
