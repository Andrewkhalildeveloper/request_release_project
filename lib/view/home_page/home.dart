import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_to_release_project/fireBase_utils.dart';
import 'package:request_to_release_project/my_theme.dart';
import 'package:request_to_release_project/view_model/bloc_view_model.dart';
import 'package:request_to_release_project/view_model/mobile_scanner.dart';
import 'package:request_to_release_project/view_model/states.dart';
import '../../model/user_model.dart';

class Home extends StatefulWidget {
  static const String routeName = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  UserModel userModel =
      UserModel(name: 'user', message: '', validation: false, token: '');
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2));
    FirebaseUtils.saveTokenToDataBase(userModel.name!);
    updateToken(userModel.name!);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // _firebaseMessaging.requestPermission();
  //   // _firebaseMessaging.getToken().then((token) {
  //   //   FirebaseUtils.saveTokenToDataBase(token ?? '1234',);
  //   //   print('Token is $token');
  //   // });
  //   FirebaseMessaging.onMessage.listen(
  //           (remoteMessage) {
  //         print(remoteMessage.data);
  //       },
  //       onError: (error) {
  //         print(error.toString());
  //       },
  //       onDone: (){
  //         print('done');
  //       }
  //   );
  //   FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage){
  //     print('Message clicked');
  //   });
  // }
  BlocViewModel viewModel = BlocViewModel();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocViewModel, BlocStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is InitialLoadingState) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        MobileScanner.scan();
                      },
                      // context.read<BlocViewModel>().requestToReleaseButton(),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 100),
                          backgroundColor: MyTheme.primaryGreen),
                      child: Text(
                        'Request to release',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        dialog();
                      },
                      // context.read<BlocViewModel>().requestToReleaseButton(),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 100),
                          backgroundColor: MyTheme.primaryGreen),
                      child: Text(
                        'Show Code',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        });
  }

  dialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(content: MobileScanner.showCode()),
    );
  }

  Future<void> updateToken(String uId) async {
    String? newToken = await FirebaseMessaging.instance.getToken();

    if (newToken != null) {
      if (newToken != userModel.token) {
        print('token changed');
        print('$newToken');
        print(('${userModel.token}'));
        setState(() {
          userModel.token = newToken;
        });
        // var docRef =FirebaseFirestore.instance.collection(userModel.name!).doc();
        // var userRef =await docRef.get();
        // if(userRef.exists){
        //   String currentToken = userRef.data()?['token'];
        //   if(currentToken ==newToken){
        //     await docRef.update({
        //       'token':newToken
        //     }).then((_) {
        //       print('Token updated successfully');
        //       print('$newToken');
        //     });
        //   }else {
        //     print('Token is the same, no update needed');
        //   }
      }
      // else {
      //
      //   // If the document does not exist, create it with the new token
      //   // await docRef.set({
      //   //   'token': newToken,
      //   // }).then((_) {
      //   //   print('Token set successfully');
      //   // }).catchError((error) {
      //   //   print('Failed to set token: $error');
      //   // });
      // }
    }
  }
}
