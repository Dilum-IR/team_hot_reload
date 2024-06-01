import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../app/model/user_model.dart';
import '../components/widget/comman_widget/alert_popup.dart';
import 'exceptions/crud_failure.dart';
import 'exceptions/signin_failure.dart';
import 'exceptions/signup_failure.dart';

class AuthenticationService extends GetxController {
  static AuthenticationService get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore service = FirebaseFirestore.instance;

  Future<UserCredential> registerUser(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return user;
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      final ex = SignUpFailure();
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  // user another data stored for create a new document
  Future<void> insertUser(
      {required String collection, required UserModel user}) async {
    try {
      await service.collection(collection).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      AlertPopup.warning(
        title: "User Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      AlertPopup.warning(
        title: "User Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final user = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value;
      });
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      final ex = SignInFailure.code(e.code);
      AlertPopup.warning(
        title: "User SignIn Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      throw _;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      final ex = SignUpFailure();
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      final ex = SignUpFailure();
      AlertPopup.warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<void> logoutUser() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print("\n\n${e.code}\n\n");
      final ex = SignUpFailure.code(e.code);
      print("firebase exception ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignUpFailure();
      print("exception-1 ${ex.message}");
      throw ex;
    }
  }
}
