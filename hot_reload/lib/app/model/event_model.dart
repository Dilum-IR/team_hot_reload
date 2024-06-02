import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_reload/utils/constraints/texts.dart';

class EventModel {
  late String id;
  late String name;
  late String causeArea;
  late String description;
  late String startDate;
  late String endDate;
  late String startTime;
  late String contactNumber;
  late String contactEmail;
  late double latitude;
  late double longitude;
  late int minAge;
  late int maxAge;
  late String location;
  late List<String> imageUrl;
  late List<String> tags;
  late List<String> applicants;
  late String organizerId;
  late int numberOfVolunteersNeeded;
  late List<String> skills;
  late String deadline;

  late String notes;
  late List<String> volunteers;

  EventModel.create({
    // required this.id,
    required this.name,
    required this.causeArea,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.contactNumber,
    required this.contactEmail,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.minAge,
    required this.maxAge,
    required this.numberOfVolunteersNeeded,
    required this.skills,
    required this.notes,
    required this.deadline,
    required this.imageUrl,
    required this.tags,
    required this.organizerId,
    required this.applicants,
    required this.volunteers,
  });

  EventModel.view({
    required this.id,
    required this.name,
    required this.causeArea,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.contactNumber,
    required this.contactEmail,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.minAge,
    required this.maxAge,
    required this.numberOfVolunteersNeeded,
    required this.skills,
    required this.notes,
    required this.deadline,
    required this.imageUrl,
    required this.tags,
    required this.organizerId,
    required this.applicants,
    required this.volunteers,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "startDate": startDate,
      "endDate": endDate,
      "contactNumber": contactNumber,
      "contactEmail": contactEmail,
      "imageUrl": imageUrl,
      "tags": tags,
      "applicants": applicants,
      "organizerId": organizerId,
      "causeArea": causeArea,
      "numberOfVolunteersNeeded": numberOfVolunteersNeeded,
      "skills": skills,
      "deadline": deadline,
      // "registrationLink": registrationLink,
      "notes": notes,
      "minAge": minAge,
      "maxAge": maxAge,
      "location": location,
      "startTime": startTime,
      "volunteers": volunteers
    };
  }

  factory EventModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    print(data);
    return EventModel.view(
      id: doc.id ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      contactEmail: data['contactEmail'] ?? '',
      imageUrl: List<String>.from(data['imageUrl']) ?? [],
      tags: List<String>.from(data['tags'] ?? []),
      applicants: List<String>.from(data['applicants'] ?? []),
      organizerId: data['organizerId'] ?? '',
      causeArea: data['causeArea'] ?? '',
      numberOfVolunteersNeeded: data['numberOfVolunteersNeeded'] ?? 0,
      skills: List<String>.from(data['skills'] ?? []),
      deadline: data['deadline'] ?? '',
      // registrationLink: data['registrationLink'] ?? '',
      notes: data['notes'] ?? '',
      startTime: data['startTime'],
      location: data['location'],
      minAge: data['minAge'],
      maxAge: data['maxAge'],
      volunteers: List<String>.from(data["volunteers"]) ?? [],
    );
  }

  EventModel.updateImage({required this.id, required this.imageUrl});

  Map<String, dynamic> toJsonUpdateImage() {
    return {
      "id": id,
      "imageUrl": imageUrl,
    };
  }
}
