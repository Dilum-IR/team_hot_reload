import 'package:cloud_firestore/cloud_firestore.dart';

class Qualification {
  final String id;
  final String qualifi;
  final String date;
  final String desc;

  Qualification({
    required this.id,
    required this.qualifi,
    required this.date,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "qualification": {
        "qualifi": qualifi,
        "date": date,
        "desc": desc,
      }
    };
  }

  factory Qualification.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    if (data['qualification'] != null) {
      return Qualification(
        id: data['id'] ?? '',
        qualifi: data["qualification"]['qualifi'] ?? '',
        date: data["qualification"]['date'] ?? '',
        desc: data["qualification"]['desc'] ?? '',
      );
    } else {
      return Qualification(
        id: data['id'] ?? '',
        qualifi: '',
        date: '',
        desc: '',
      );
    }
  }
}
