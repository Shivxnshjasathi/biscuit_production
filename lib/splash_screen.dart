
import 'package:biscuit_production/auth_pages/auth_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  

  @override
  void initState() {
    super.initState();
    GetToken();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AuthScreen();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1500),
            tween: Tween<double>(begin: 0,end: 6.3),
            builder: (BuildContext context, double value, Widget? child) {
              print(value);
              return Transform.rotate(
                angle: value,
                child: child);
            },
            child: Image.asset('assets/logos/biscuit-logo.png'),
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 2000),
            tween: Tween<double>(begin: 0,end: 1),
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: const Text("Biscuit",style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
          ),
          
        ],
      ),
    );
  }
}
