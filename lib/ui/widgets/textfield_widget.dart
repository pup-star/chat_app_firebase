import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/string.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.focusNode,
    this.isSearch = false,
    this.isChatText = false,
    this.controller,
    this.onTap,
    this.isPassword = false,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isSearch;
  final bool isChatText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isChatText ? 35.h : null,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding:
              isChatText ? EdgeInsets.symmetric(horizontal: 12.w) : null,
          filled: true,
          fillColor: isChatText ? white : grey.withOpacity(0.12),
          hintText: hintText,
          hintStyle: body.copyWith(color: grey),
          suffixIcon: isSearch
              ? Container(
                  height: 55,
                  width: 55,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.asset(searchIcon),
                )
              : isChatText
                  ? InkWell(
                      onTap: onTap,
                      child: Icon(Icons.send),
                    )
                  : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(isChatText ? 20.r : 10.r),
          ),
        ),
      ),
    );
  }
}
