import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeJobPost {
  final String id;
  final String industry;
  final String category;
  final String job_position;

  final String job_type;
  final String type_of_workspace;
  final String location;
  final int max_salary;
  final int min_salary;
  final String job_desc;
  final String require;
  final String responsi;
  final String about;
  final int view;
  final bool is_view;
  final Timestamp post_time;
  final String image_url;
  final double lat;
  final double long;

  EmployeeJobPost(
      {required this.id,
      required this.industry,
      required this.category,
      required this.job_position,
      required this.job_type,
      required this.type_of_workspace,
      required this.location,
      required this.max_salary,
      required this.min_salary,
      required this.job_desc,
      required this.require,
      required this.responsi,
      required this.about,
      required this.view,
      required this.is_view,
      required this.image_url,
      required this.post_time,
      required this.lat,
      required this.long});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": {
        "industry": industry,
        "category": category,
        "job_position": job_position,
        "job_type": job_type,
        "type_of_workspace": type_of_workspace,
      },
      "location": location,
      "max_salary": max_salary,
      "min_salary": min_salary,
      "details": {
        "job_desc": job_desc,
        "require": require,
        "responsi": responsi,
        "about": about,
      },
      "view": view,
      "is_view": is_view,
      "image_url": image_url,
      "post_time": post_time,
      "lat": lat,
      "long": long
    };
  }

  factory EmployeeJobPost.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EmployeeJobPost(
      id: data['id'] ?? '',
      industry: data["description"]['industry'] ?? '',
      category: data["description"]['category'] ?? '',
      job_position: data["description"]['job_position'] ?? '',
      job_type: data["description"]['job_type'] ?? '',
      type_of_workspace: data["description"]['type_of_workspace'] ?? '',
      location: data['location'] ?? '',
      max_salary: data['max_salary'] ?? 0,
      min_salary: data['min_salary'] ?? 0,
      job_desc: data["details"]['job_desc'] ?? '',
      require: data["details"]['require'] ?? '',
      responsi: data["details"]['responsi'] ?? '',
      about: data["details"]['about'] ?? '',
      view: data['view'] ?? 0,
      is_view: data['is_view'] ?? true,
      post_time: data['post_time'] ?? "",
      image_url: data['image_url'] ?? "",
      lat: data['lat'] ?? 7.927363,
      long: data['long'] ?? 80.687698,
    );
  }
}
