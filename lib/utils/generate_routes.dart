import 'package:flutter/material.dart';
import 'package:trackbucks/screens/screens.dart';

Route<dynamic>? generateRoutes(RouteSettings settings) {
  if (settings.name == PayeeScreen.path) {
    final upiId = settings.arguments as String;
    return MaterialPageRoute(builder: (context) => PayeeScreen(upiId: upiId));
  }

  return null;
}
