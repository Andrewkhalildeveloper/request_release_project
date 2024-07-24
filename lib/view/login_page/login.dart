import 'package:flutter/material.dart';
import 'package:request_to_release_project/fireBase_utils.dart';
import 'package:request_to_release_project/model/user_model.dart';
import 'package:request_to_release_project/view/home_page/home.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserModel userModel = UserModel(
    name: 'user',
    message: '',
    validation: false,
    token: '',
  );
  String name1 = 'Admin';
  String name2 = 'user';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Admin',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                addingUser();
              },
              child: Text(
                'User',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  addingUser() {
    FirebaseUtils.addUser(userModel).timeout(
      const Duration(milliseconds: 20),
      onTimeout: () {
        showDialog(
          context: context,
          builder: (alertContext) {
            return AlertDialog(
              content: Text(
                'Welcome $name2',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(alertContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
