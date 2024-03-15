import 'dart:convert';

KodeQuesionerModel kodeQuesionerModelFromJson(String str) =>
    KodeQuesionerModel.fromJson(json.decode(str));

String kodeQuesionerModelToJson(KodeQuesionerModel data) =>
    json.encode(data.toJson());

class KodeQuesionerModel {
  String message;
  List<Datum> data;

  KodeQuesionerModel({
    required this.message,
    required this.data,
  });

  factory KodeQuesionerModel.fromJson(Map<String, dynamic> json) =>
      KodeQuesionerModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String kodePertanyaan;

  Datum({
    required this.id,
    required this.kodePertanyaan,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        kodePertanyaan: json["kode_pertanyaan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_pertanyaan": kodePertanyaan,
      };
}
