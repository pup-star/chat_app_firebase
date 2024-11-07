import 'dart:async';

import 'package:chat_app/core/constants/string.dart';
import 'package:chat_app/ui/screens/bottom_navigation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, wrapper);
    });
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            setState(() {
              isConnectedToInternet = false;
            });
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
      }
    });
  }

  //------------------------ timer
  // Timer? _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer(Duration(seconds: 3), () {
  //     Navigator.pushNamed(context, wrapper);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _internetConnectionStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            frame,
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              logo,
              height: 170,
              width: 170,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
