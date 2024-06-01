import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/model/education.dart';
import '../app/model/employee_job_post.dart';
import '../app/model/user_model.dart';
import '../components/widget/comman_widget/alert_popup.dart';
import 'exceptions/crud_failure.dart';

class CrudServices {
  final FirebaseFirestore service = FirebaseFirestore.instance;

  // insert only when have userID with data into the collection
  Future<void> insert(
      {required String collection, required dynamic data}) async {
    try {
      await service.collection(collection).doc(data.id).set(data.toJson());
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  /// find each collection include some data [only user model data]
  Future<List<UserModel>> findOne(
      {required String collection, required String filed}) async {
    late List<UserModel> data = [];

    try {
      await service.collection(collection).doc(filed).get().then((value) {
        if (value.exists) {
          data.add(UserModel.fromSnapshot(value));
        }
        // login user data collect
        // if (collection == "Users") {
        // }
        // print(data);
      });
      return data;
    } on FirebaseException catch (e) {
      // print("\n\n${e.code}\n\n");
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: "${ex.message}.",
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  // {
  // "city":{
  //    "country : "matara"
  // } }

  // then,update dataArray is { "city.country" : "matara"}
  // if you want to deleted some field then ,  { "city.country" : FiledValue.delete()}
  Future<dynamic> update(
      {required String collection, required dynamic data}) async {
    try {
      await service.collection(collection).doc(data['id']).update(data);
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      throw ex;
    }
  }

  Future<dynamic> jobDelete(
      {required String collection, required String filed}) async {
    try {
      await service.collection(collection).doc(filed).delete();
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );

      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  // job services
  Future<void> jobInsert(
      {required String collection, required dynamic data}) async {
    // print(data);

    try {
      await service.collection(collection).doc().set(data);
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      print(_);
      final ex = CrudFailure();

      // print("exception-1 ${ex.message}");
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<List<EmployeeJobPost>> jobFindOneId(
      {required String collection,
      required String key,
      required String filed}) async {
    try {
      final sanpshot = await service
          .collection(collection)
          .where(key, isEqualTo: filed)
          .get();
      return sanpshot.docs
          .map((obj) => EmployeeJobPost.fromSnapshot(obj))
          .toList();
    } on FirebaseException catch (e) {
      // print("\n\n${e.code}\n\n");
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  Future<dynamic> jobFindAll({required String collection}) async {
    try {
      final sanpshot = await service.collection(collection).get();
      return sanpshot.docs
          .map((obj) => EmployeeJobPost.fromSnapshot(obj))
          .toList();
    } on FirebaseException catch (e) {
      // print("\n\n${e.code}\n\n");
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  Future<dynamic> findJobOne(
      {required String collection,
      required String filed,
      required Timestamp date}) async {
    try {
      final sanpshot = await service
          .collection(collection)
          .where("id", isEqualTo: filed)
          .where("post_time", isEqualTo: date)
          .get();

      return sanpshot.docs
          .map((obj) => EmployeeJobPost.fromSnapshot(obj))
          .single;

      // await service.collection(collection).doc(filed).where(key, isEqualTo: filed).get().then((value) {
      //   final data = EmployeeJobPost.fromSnapshot(value);
      //   print(data);
      // });
    } on FirebaseException catch (e) {
      // print("\n\n${e.code}\n\n");
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      print("_");
      print(_);

      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }

  Future<dynamic> recomendJobs({
    required String collection,
    required List skills,
  }) async {
    try {
      final sanpshot = await service
          .collection(collection)
          // .where("skills", arrayContains: skills)
          .where("skills", whereIn: skills)
          .get();

      return sanpshot.docs
          .map((obj) => EmployeeJobPost.fromSnapshot(obj))
          .single;
    } on FirebaseException catch (e) {
      // print("\n\n${e.code}\n\n");
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      // print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      print("_");
      print(_);

      final ex = CrudFailure();
      AlertPopup.warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      // print("exception-1 ${ex.message}");
      throw ex;
    }
  }
}
