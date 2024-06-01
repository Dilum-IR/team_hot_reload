import 'package:cloud_firestore/cloud_firestore.dart';

class Education {
  final String id;
  final String institute;
  final String degree;
  final String study_field;
  final String startDate;
  final String endDate;
  final String desc;

  Education({
    required this.id,
    required this.institute,
    required this.degree,
    required this.study_field,
    required this.startDate,
    required this.endDate,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "education": {
        "institute": institute,
        "degree": degree,
        "study_field": study_field,
        "startDate": startDate,
        "endDate": endDate,
        "desc": desc,
      }
    };
  }

  factory Education.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    if (data['education'] != null)
      return Education(
        id: data['id'] ?? '',
        institute: data['education']['institute'] ?? '',
        degree: data['education']['degree'] ?? '',
        study_field: data['education']['study_field'] ?? '',
        startDate: data['education']['startDate'] ?? '',
        endDate: data['education']['endDate'] ?? '',
        desc: data['education']['desc'] ?? '',
      );
    else
      return Education(
        id: data['id'] ?? '',
        institute: '',
        degree: '',
        study_field: '',
        startDate: '',
        endDate: '',
        desc: '',
      );
  }
}
