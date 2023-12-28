import 'package:flutter/material.dart';

showsnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  ));
}
