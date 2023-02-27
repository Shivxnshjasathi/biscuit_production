import 'package:biscuit_production/auth_pages/auth_screen.dart';
import 'package:biscuit_production/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logged In with token : \n $userToken",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                RemoveToken();
                userToken = null;
                Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AuthScreen();
            },
          ),
        );
              },
              child: Text(
                "SignOut",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )),
    );
  }
}
