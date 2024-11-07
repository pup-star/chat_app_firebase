import 'dart:async';
import 'dart:math';

import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/home/home_viewmodel.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeViewmodel(DatabaseService()),
      child: Consumer<HomeViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Column(
              children: [
                35.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Me",
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
                userProvider.user == null
                    ? const CircularProgressIndicator()
                    : InkWell(
                        // onTap: () {
                        //   AuthService().logout();
                        // },
                        // child: Text(
                        //   userProvider.user.toString(),
                        // ),
                        child: ListTile(
                          //onTap: onTap,
                          tileColor: grey.withOpacity(0.12),

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 3,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          leading: CircleAvatar(
                            //backgroundColor: grey.withOpacity(0.5),
                            backgroundColor: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            radius: 25,
                            child: Text(
                              userProvider.user!.name![0],
                              style: h,
                            ),
                          ),
                          title: Text(userProvider.user!.name.toString()),
                          subtitle: const Text(
                            "Online activate",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Now",
                                style: TextStyle(color: grey),
                              ),
                              10.verticalSpace,
                              CircleAvatar(
                                radius: 9.r,
                                backgroundColor: Colors.green,
                                child: Center(
                                  child: Text(
                                    "",
                                    style: small.copyWith(color: white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
