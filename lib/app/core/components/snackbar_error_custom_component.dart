import 'package:flutter/material.dart';

class SnackBarErrorCustom {
  final BuildContext context;
  final String error;
  SnackBarErrorCustom({required this.context, required this.error});
  ScaffoldFeatureController call() {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      backgroundColor: Theme.of(context).errorColor,
      content: Text(error, style: const TextStyle(fontSize: 18)),
    ));
  }
}
