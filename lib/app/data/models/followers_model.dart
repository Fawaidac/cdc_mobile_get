class Follower {
  String? id;
  String? fullname;
  String? email;
  String? nik;
  String? noTelp;
  String? foto;
  String? alamat;
  String? about;
  String? gender;
  String? level;
  String? linkedin;
  String? facebook;
  String? instagram;
  String? twiter;
  int? accountStatus;
  bool? isFollow;
  String? lat;
  String? long;

  Follower({
    this.id,
    this.fullname,
    this.email,
    this.nik,
    this.noTelp,
    this.foto,
    this.alamat,
    this.about,
    this.gender,
    this.level,
    this.linkedin,
    this.facebook,
    this.instagram,
    this.twiter,
    this.accountStatus,
    this.isFollow,
    this.lat,
    this.long,
  });

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    nik = json['nik'];
    noTelp = json['no_telp'];
    foto = json['foto'];
    alamat = json['alamat'];
    about = json['about'];
    gender = json['gender'];
    level = json['level'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twiter = json['twiter'];
    accountStatus = json['account_status'];
    isFollow = json['isFollow'];
    lat = json['latitude'];
    long = json['longtitude'];
  }
}

class FollowersModel {
  late int totalFollowers;
  List<Follower>? followers;

  FollowersModel({required this.totalFollowers, required this.followers});

  FollowersModel.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }
}

class FollowedModel {
  late int totalFollowers;
  List<Follower>? followed;

  FollowedModel({required this.totalFollowers, required this.followed});

  FollowedModel.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['data']['total_followers'];
    if (json['followed'] != null) {
      followed = [];
      json['followed'].forEach((v) {
        followed!.add(Follower.fromJson(v));
      });
    }
  }
}

class FollowersListModel {
  List<Follower>? followers;

  FollowersListModel({this.followers});

  FollowersListModel.fromJson(Map<String, dynamic> json) {
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }
}
