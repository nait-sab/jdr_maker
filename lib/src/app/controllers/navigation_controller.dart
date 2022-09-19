import 'package:flutter/material.dart';

/// Classe : Navigation
///
/// Type : Controller
///
/// Contient la route actuelle dans l'application
class NavigationController extends ChangeNotifier {
  String currentRoute = "/";

  void changerRoute(String routeName) {
    currentRoute = routeName;
    notifyListeners();
  }
}
