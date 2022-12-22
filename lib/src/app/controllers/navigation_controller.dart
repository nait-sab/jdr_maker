import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Classe : Navigation
///
/// Type : Controller
///
/// Contient la route actuelle dans l'application
class NavigationController extends ChangeNotifier {
  String _route = "/";

  void _changerRoute(String route) {
    _route = route;
    notifyListeners();
  }

  /// Changer la route actuelle
  static void changerRoute(BuildContext context, String route) {
    Provider.of<NavigationController>(context, listen: false)._changerRoute(route);
  }

  /// Récupérer la route actuelle
  static String getRoute(BuildContext context) {
    return Provider.of<NavigationController>(context, listen: false)._route;
  }
}
