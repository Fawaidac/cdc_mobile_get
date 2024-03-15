import 'dart:convert';

PaketQuesionerModel paketQuesionerModelFromJson(String str) =>
    PaketQuesionerModel.fromJson(json.decode(str));

String paketQuesionerModelToJson(PaketQuesionerModel data) =>
    json.encode(data.toJson());

class PaketQuesionerModel {
  List<Datum> data;
  String message;
  int code;
  bool status;

  PaketQuesionerModel({
    required this.data,
    required this.message,
    required this.code,
    required this.status,
  });

  factory PaketQuesionerModel.fromJson(Map<String, dynamic> json) =>
      PaketQuesionerModel(
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
  String kodePertanyaan;
  String pertanyaan;
  int tipeId;
  int idPaketQuesioners;
  String isRequired;
  String? options;
  int index;
  DateTime createdAt;
  DateTime updatedAt;
  Tipe tipe;

  Datum({
    required this.id,
    required this.kodePertanyaan,
    required this.pertanyaan,
    required this.tipeId,
    required this.idPaketQuesioners,
    required this.isRequired,
    required this.options,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
    required this.tipe,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        kodePertanyaan: json["kode_pertanyaan"],
        pertanyaan: json["pertanyaan"],
        tipeId: json["tipe_id"],
        idPaketQuesioners: json["id_paket_quesioners"],
        isRequired: json["is_required"],
        options: json["options"],
        index: json["index"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tipe: Tipe.fromJson(json["tipe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_pertanyaan": kodePertanyaan,
        "pertanyaan": pertanyaan,
        "tipe_id": tipeId,
        "id_paket_quesioners": idPaketQuesioners,
        "is_required": isRequired,
        "options": options,
        "index": index,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tipe": tipe.toJson(),
      };
}

class Tipe {
  int id;
  String displayValue;
  String value;
  DateTime createdAt;
  DateTime updatedAt;

  Tipe({
    required this.id,
    required this.displayValue,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tipe.fromJson(Map<String, dynamic> json) => Tipe(
        id: json["id"],
        displayValue: json["display_value"],
        value: json["value"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "display_value": displayValue,
        "value": value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
