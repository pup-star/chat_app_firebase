import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/ui/screens/auth/signup/signup_screen.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
        child: Column(
          children: [
            35.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "LogOut",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            CustomButton(
              text: "Logout",
              onPressed: () {
                AuthService().logout();
                Provider.of<UserProvider>(context, listen: false).clearUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
