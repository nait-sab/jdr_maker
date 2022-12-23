import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Classe : Navigation
///
/// Type : Controller
///
/// Contient la route actuelle dans l'application
class NavigationController extends ChangeNotifier {
  String route = "/";

  void changerRoute(String route) {
    this.route = route;
    notifyListeners();
  }

  /// Changer la route actuelle
  static void changerView(BuildContext context, String route) {
    Provider.of<NavigationController>(context, listen: false).changerRoute(route);
  }

  /// Récupérer la route actuelle
  static String getRoute(BuildContext context) {
    return Provider.of<NavigationController>(context, listen: false).route;
  }
}
