import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final IconData icon;
  final bool? isObscure;
  final VoidCallback? onPressed;

  TextFieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.inputType,
    this.isObscure,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      width: Get.width,
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: isObscure ?? false,
        cursorColor: appMainColor,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 2, left: 8),
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: isObscure != null
              ? (IconButton(
                  icon: isObscure == true
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: onPressed,
                ))
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: appMainColor),
          ),
        ),
      ),
    );
  }
}
