import 'package:chat_app/core/constants/string.dart';
import 'package:chat_app/ui/screens/bottom_navigation/bottom_navigation_viewmodel.dart';
import 'package:chat_app/ui/screens/bottom_navigation/chats_list/chats_list_screen.dart';
import 'package:chat_app/ui/screens/bottom_navigation/profile/profile_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const ChatsListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    final items = [
      BottomNavigationBarItem(
          label: "",
          icon: BottomNavButton(
            iconPath: homeIcon,
          )),
      BottomNavigationBarItem(
          label: "",
          icon: BottomNavButton(
            iconPath: chatIcon,
          )),
      BottomNavigationBarItem(
          label: "",
          icon: BottomNavButton(
            iconPath: profileIcon,
          )),
    ];
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationViewmodel(),
      child: Consumer<BottomNavigationViewmodel>(builder: (context, model, _) {
        return currentUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: BottomNavigationScreen._screens[model.currentIndex],
                bottomNavigationBar:
                    CustomNavBar(onTap: model.setIndex, items: items),
              );
      }),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    this.onTap,
    required this.items,
  });

  final void Function(int)? onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    final borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          onTap: onTap,
          items: items,
        ),
      ),
    );
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.iconPath,
  });

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: Image.asset(
        iconPath,
        height: 35,
        width: 35,
      ),
    );
  }
}
