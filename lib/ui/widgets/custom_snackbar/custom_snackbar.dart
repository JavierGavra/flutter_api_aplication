import 'package:flutter/material.dart';

SnackBar _customSnackBar(
  BuildContext context, {
  required String title,
  Duration? duration,
  Icon? icon,
}) {
  return SnackBar(
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    duration: duration ?? const Duration(seconds: 3),
    content: icon == null
        ? Text(title)
        : Row(
            children: [
              icon,
              SizedBox(width: 15),
              Text(title),
            ],
          ),
  );
}

void showCustomSnackBar(
  BuildContext context, {
  required String title,
  Duration? duration,
  Icon? icon,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      _customSnackBar(
        context,
        title: title,
        duration: duration,
        icon: icon,
      ),
    );
