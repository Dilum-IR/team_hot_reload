import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hot_reload/utils/constraints/texts.dart';

class UserModel {
  final String id;
  late String name;
  late String email;
  late String userType;

  late String dob;
  late String phone;
  late List links;
  late String image_url;

  UserModel.register({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userType": userType,
      "name": name,
      "email": email,
    };
  }

  // about me model
  UserModel.aboutMe(
      {required this.id,
      required this.name,
      required this.email,
      required this.userType,
      required this.phone,
      required this.dob,
      required this.links,
      required this.image_url});

  Map<String, dynamic> toJsonAboutMe() {
    return {
      "id": id,
      "userType": userType,
      "name": name,
      "dob": dob,
      "email": email,
      "phone": phone,
      "links": links,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.aboutMe(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      userType: data['userType'] ?? '',
      phone: data['phone'] ?? '',
      dob: data['dob'] ?? '',
      links: data['links'] ?? [],
      image_url: data['image_url'] ?? KTexts.profileImg,
    );
  }

  UserModel.addImage({required this.id, required this.image_url});

  Map<String, dynamic> toJsonAddImage() {
    return {
      "id": id,
      "image_url": image_url,
    };
  }
}

// Future<void> getUsers() async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
//     List<User> users = querySnapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
//     // Now you have a list of User objects
//     print(users);
//   } catch (e) {
//     print('Error fetching users: $e');
//   }
// }
