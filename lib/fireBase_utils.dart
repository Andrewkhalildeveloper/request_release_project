// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:request_to_release_project/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static CollectionReference<UserModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.modelName)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              UserModel.fromFireStore(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toFireStore(),
        );
  }
  // static CollectionReference<Token> getTokenCollection() {
  //   return FirebaseFirestore.instance
  //       .collection(UserModel.modelName)
  //       .withConverter(
  //           fromFirestore: (snapshot, _) =>
  //               Token.fromFireStore(snapshot.data()!),
  //           toFirestore: (token, _) => token.toFireStore());
  // }

  static Future<void> addUser(UserModel user) {
    return getCollection().doc(user.name).set(user);
  }

  static Future<void> editValidation(UserModel user) {
    var isValid =
        getCollection().doc(user.name).update({'validation': user.validation});
    return isValid;
  }

  static Future<void> saveTokenToDataBase(String uId) async {
    String? token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      DocumentReference<Map<String, dynamic>> userData =
          FirebaseFirestore.instance.collection(UserModel.modelName).doc(uId);

      userData.update({'token': token});
    }
  }

  static Future<UserModel?> getToken(String uId) async {
    var querySnapshot = await getCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static void sendOtp(String targetUserId, String otp) async {
    await FirebaseFirestore.instance
        .collection(UserModel.modelName)
        .doc(targetUserId)
        .collection('notification')
        .add(
      {
        'title': 'your OTP code',
        'body': 'your OTP code is $otp',
        'targetUserId': targetUserId
      },
    );
  }

  static Future<void> registerUserName(
      String emailAddress, String password) async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginUser(String emailAddress, String password) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
