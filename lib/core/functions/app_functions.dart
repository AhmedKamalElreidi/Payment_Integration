import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages

class AppFunctions {
  static navigateTo({required context, required navigatedScreen}) =>
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigatedScreen));
  static navigateAndFinishTo({required context, required navigatedScreen}) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => navigatedScreen),
        (route) => false,
      );

  static popNavigate({required context}) => Navigator.pop(context);

  static Future<String> showDatePickerComponent({required context}) async {
    final value = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (value != null) {
      return "${value.year}-${value.month}-${value.day}";
    } else {
      return "";
    }
  }

  static Future<String> showTimePickerComponent({required context}) async {
    final value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (value != null) {
      return "${value.hour}:${value.minute}";
    } else {
      return "";
    }
  }

  static showToast({required String text}) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 18);

  static showModelBottomSheetWithBlurBackground(
          {required context, required Widget widget}) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: widget,
        ),
      );
}
