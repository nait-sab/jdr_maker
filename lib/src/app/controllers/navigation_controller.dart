import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  static void changerView(BuildContext context, String route) {
    Provider.of<NavigationController>(context, listen: false).changerRoute(route);
  }
}
