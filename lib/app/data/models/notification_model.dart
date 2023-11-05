class NotificationsModel {
  String? id;
  String? userId;
  String? type;
  String? message;
  String? idBody;
  String? createdAt;
  String? updatedAt;

  NotificationsModel(
      {this.id,
      this.userId,
      this.type,
      this.message,
      this.idBody,
      this.createdAt,
      this.updatedAt});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    message = json['message'];
    idBody = json['id_body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['message'] = this.message;
    data['id_body'] = this.idBody;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
