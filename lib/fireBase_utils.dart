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
  static Future<void> getTokenCollection() async {
    final serviceAccountJson ={
        "type": "service_account",
        "project_id": "request-project-357d5",
        "private_key_id": "9ebfbedc01ad0cd5b31acf9eabc80f1ebeb0b920",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCmXKWROB/85vwA\nhEc4iAYnJPUCphyibi4/R/tYDxB6Hv6jZve3HeOthrIMBxGV5dIE98e3/Z7oMjXu\neRJ9E+bqH8s/kcqdTh4R6V/ymQUS+btRymwTKrPVLHgZfwMzFG0v5qqyuaHdUEvK\nM9L3hrePLR+uv51Y9se00A9BZkYpqu/EUkY35dkHXAUV8tnQl+HWONPuU7Yp+iZU\n3LyvRkCZAOXxxhJQdyRx/thNz7Eb9yE/pFIOBGXruKXyhLg1oC05y0r339E0AEmg\nVJWVqdcZHARFazbtUwzAIdyi1naW6zYd2t5/V/PAArcIyrlzZC3eSjntUYxukkB7\nTOrIGzjvAgMBAAECggEARY5M5zepICtPR8QGpxswP2OTUSU0qbEZgvnMm9fIktas\nrpMZlSVZES9U9/RopNyu/8a9aS8QJpL/u5JBaaxNiqv6ZbzGExkbN2/03tCdr35c\nlGjm4OikwcdS+44AP3YV5MYzroAwrgCpf4RFe5qG2sUKDx0sY4rimrW2+ygQw9B4\nV/N/z29rPJGjYnRSwnswUTxnZLrZlWlcSKueAFb9LOVTU9aeW+UKCTVtxqDVo0ZP\n90+/sye4gUuBCvSidXZD6Xw1aAQoR3Xalls0GEUG1kHolF+DxPD6LWBY0zhcZJlO\n/BEpGu7mUw4samDPzuacu2lm3VJBKuCeAusRSHIm4QKBgQDepSvYKP1E1q4F5Pp2\nQn2xp5oqS6iMUd188qcgMJ5dIPLWBkUsZ7mTHF0TJFRsFQ2qYYVPkii3cnmlPPGm\nv5b9MnjKzfarhoGC/6qAmoEFGZtYSTD8GefDWve6aDCx5Et8fjQZoA2xYIeSDDPS\ntnjtuCARHXC1eaWnTscQX1Cs/wKBgQC/SOnfYtdmkdrCHfXm10QCFMVkRhbapx6G\nEV4koyhuJ0hLFfxB8ITuyZbnm65owwwAi6o3WInoaF+AwaEuYp/RHkHtexf/iPH7\nB2rpXWWmWKAQnPV058K0mYHJB193zFQb5XCzeaaI8sYWYPv4G9iwpQTZ8X4GxYVv\n38MmHjREEQKBgCExyQ6qVdBsnXd9gyYclbbmASMrMo7xKa+WUfqHpSTHY80rFCch\ns9ZOFUZkVT3kCayMa57IcM+g/qf3JSQyTmWjn8TE3nEGVcrdKWORJYlIHxQTnX0I\ns7g5mNOu8wuiuOpvun7TkRcQCEZrEVLqJ69xkz5aAFLeNydxpFY5j8KrAoGAAIo7\nJsdHpmF5BZ1CCXHIHl1ipULRY7KfEm/QHThcr9rqiFO6j5EXPvlQtLyqxF7wlLvQ\nMjHMydwpkNp7Ev9yRgvY0cvMKIuBa1z8/0WlOM/9O67Fvpu83/ei9ydPLK5l+mIu\nbENGphJRXtTNQUkK1ozQs7DL00cRdlxiV6Q0L5ECgYAquDQ8atp1hzFCM1X1bkrx\nZ9SVxv3ezT/qc7jOqxkTd7b5lWC3gnqI42rq46vuq23/oSW0OPc8iQygUgaK94Mk\n9GVJeNBmqy40ZR7xUzt3Kw4mlyX1MowcbogS3GLD+KV7QAEYJ0Kqc/2nIFQkZelO\n+CLQ61lQ5iSSYzl9TZpuEw==\n-----END PRIVATE KEY-----\n",
        "client_email": "serviceaccount@request-project-357d5.iam.gserviceaccount.com",
        "client_id": "115511166288189870982",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/serviceaccount%40request-project-357d5.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      };
  }

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
      var userData =
          FirebaseFirestore.instance.collection(UserModel.modelName).doc(uId);
      userData.update({'token': token});
    }
  }

  static Future<String?> getToken(String uId) async {
    var querySnapshot = await getCollection().doc(uId).get();
    return querySnapshot.data()?.token;
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
