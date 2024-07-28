// ignore_for_file: unused_field
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_to_release_project/fireBase_utils.dart';
import 'package:request_to_release_project/model/http_send_notification.dart';
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
  @override
  void initState() {
    super.initState();
    FirebaseUtils.saveTokenToDataBase(user.name!);
    updateToken(user.name!);
    FirebaseUtils.getToken(user.name!);

    // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    //   // Send the new token to your server or use it for testing
    //   print("New FCM Token: $newToken");
    // });
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
  // String _lastMessage = '';
  // _HomeState() {
  //   messageStreamController.listen((message) {
  //     setState(() {
  //       if (message.notification != null) {
  //         _lastMessage = 'Received a notification message:'
  //             '\nTitle=${message.notification?.title},'
  //             '\nBody=${message.notification?.body},'
  //             '\nData=${message.data}';
  //       } else {
  //         _lastMessage = 'Received a data message: ${message.data}';
  //       }
  //     });
  //   });
  // }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  UserModel user =
      UserModel(name: 'user', token: '', message: '', validation: false);

  BlocViewModel viewModel = BlocViewModel();
  @override
  Widget build(BuildContext context) {
    print('user token in build is ${user.token}');
    return BlocBuilder<BlocViewModel, BlocStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is InitialLoadingState) {
            return Scaffold(
              body: Center(
                child: Stack(
                  children: [
                    Column(
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
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            FirebaseHttpRequest.sendNotifications(user.token!);
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
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Text(
                        '',
                        style: Theme.of(context).textTheme.titleMedium,
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
      builder: (context) => AlertDialog(
        content: MobileScanner.showCode(),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseUtils.getToken(user.token!);
              FirebaseHttpRequest.sendNotifications(user.token!);
            },
            child: Text(
              'Send to admin',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateToken(String uId) async {
    String? newToken = await FirebaseMessaging.instance.getToken();
    if (newToken != null) {
      if (newToken != user.token) {
        setState(
          () {
            user.token = newToken;
          },
        );
      }
    }
  }

  //       // var docRef =FirebaseFirestore.instance.collection(userModel.name!).doc();
  //       // var userRef =await docRef.get();
  //       // if(userRef.exists){
  //       //   String currentToken = userRef.data()?['token'];
  //       //   if(currentToken ==newToken){
  //       //     await docRef.update({
  //       //       'token':newToken
  //       //     }).then((_) {
  //       //       print('Token updated successfully');
  //       //       print('$newToken');
  //       //     });
  //       //   }else {
  //       //     print('Token is the same, no update needed');
  //       //   }
  //     }
  //     // else {
  //     //
  //     //   // If the document does not exist, create it with the new token
  //     //   // await docRef.set({
  //     //   //   'token': newToken,
  //     //   // }).then((_) {
  //     //   //   print('Token set successfully');
  //     //   // }).catchError((error) {
  //     //   //   print('Failed to set token: $error');
  //     //   // });
  //     // }
  //   }
  // }
}
