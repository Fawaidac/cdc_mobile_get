
import 'package:cdc/app/data/models/educations_model.dart';
import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/data/models/jobs_model.dart';
import 'package:cdc/app/data/models/post_model.dart';

class User {
  String? id;
  String? fullname;
  String? email;
  String? tempatTanggalLahir;
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
  String? twitter;
  int? accountStatus;
  bool? isFollow;
  String? lat;
  String? long;

  User({
    this.id,
    this.fullname,
    this.email,
    this.tempatTanggalLahir,
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
    this.twitter,
    this.accountStatus,
    this.isFollow,
    this.lat,
    this.long,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      tempatTanggalLahir: json['ttl'],
      nik: json['nik'],
      noTelp: json['no_telp'],
      foto: json['foto'],
      alamat: json['alamat'],
      about: json['about'],
      gender: json['gender'],
      level: json['level'],
      linkedin: json['linkedin'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twiter'],
      accountStatus: json['account_status'],
      isFollow: json['isFollow'],
      lat: json['latitude'],
      long: json['longtitude'],
    );
  }
}

class UserDetail {
  User? user;
  List<EducationsModel>? educations;
  List<JobsModel>? jobs;

  UserDetail({
    this.user,
    this.educations,
    this.jobs,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    // Parse user
    User user = User.fromJson(json['user']);

    // Parse educations
    List<EducationsModel>? educations;
    if (json['educations'] != null) {
      educations = (json['educations'] as List)
          .map((education) => EducationsModel.fromJson(education))
          .toList();
    }

    // Parse jobs
    List<JobsModel>? jobs;
    if (json['jobs'] != null) {
      jobs =
          (json['jobs'] as List).map((job) => JobsModel.fromJson(job)).toList();
    }

    return UserDetail(
      user: user,
      educations: educations,
      jobs: jobs,
    );
  }
}

class UserFollowersInfo {
  late int totalFollowers;
  User? user;
  List<Follower>? followers;

  UserFollowersInfo(
      {required this.totalFollowers,
      required this.user,
      required this.followers});

  UserFollowersInfo.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    user = json['user'];
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }
}

class UserFollowedInfo {
  late int totalFollowers;
  User? user;
  List<Follower>? followed;

  UserFollowedInfo(
      {required this.totalFollowers,
      required this.user,
      required this.followed});

  UserFollowedInfo.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    user = json['user'];
    if (json['followed'] != null) {
      followed = [];
      json['followed'].forEach((v) {
        followed!.add(Follower.fromJson(v));
      });
    }
  }
}

class PostDetail {
  final List<PostAllModel> posts;
  final int totalPage;
  final int totalItem;

  PostDetail({
    required this.posts,
    required this.totalPage,
    required this.totalItem,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsJson = json['posts'];
    final List<PostAllModel> posts =
        postsJson.map((postJson) => PostAllModel.fromJson(postJson)).toList();
    final int totalPage = json['pagination']['total_page'];
    final int totalItem = json['pagination']['total_item'];
    return PostDetail(posts: posts, totalPage: totalPage, totalItem: totalItem);
  }
}

class Alumni {
  final User user;
  final List<Follower> followers;
  final List<EducationsModel> educations;
  final List<JobsModel> jobs;

  Alumni({
    required this.user,
    required this.followers,
    required this.educations,
    required this.jobs,
  });

  factory Alumni.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    final followersData = (json['followers'] as List<dynamic>)
        .map((followerJson) => Follower.fromJson(followerJson))
        .toList();
    final educationsData = (json['educations'] as List<dynamic>)
        .map((educationJson) => EducationsModel.fromJson(educationJson))
        .toList();
    final jobsData = (json['jobs'] as List<dynamic>)
        .map((jobJson) => JobsModel.fromJson(jobJson))
        .toList();

    return Alumni(
      user: User.fromJson(userData),
      followers: followersData,
      educations: educationsData,
      jobs: jobsData,
    );
  }
}
