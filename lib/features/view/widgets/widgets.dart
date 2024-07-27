import 'package:flutter/material.dart';
import 'package:questions_app/core/res/app_colors.dart';
import 'package:questions_app/core/res/app_style.dart';

InputDecoration textInputDecoration(String? label) {
  return InputDecoration(
// contentPadding: const EdgeInsets.symmetric(vertical: 5),
    labelText: label,
    labelStyle: labelStyle,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
