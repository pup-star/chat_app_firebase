import 'package:chat_app/core/constants/string.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/auth/signup/signup_screen.dart';
import 'package:chat_app/ui/screens/bottom_navigation/chats_list/chat_room/chat_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/ui/screens/splash/splash_screen.dart';
import 'package:chat_app/ui/screens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      //Auth
      case signup:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      //Home
      case home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case wrapper:
        return MaterialPageRoute(builder: (context) => Wrapper());
      case chatRoom:
        return MaterialPageRoute(
            builder: (context) => ChatScreen(receiver: args as UserModel));
      default:
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("No Route found"),
            ),
          ),
        );
    }
    //return null;
  }
}
