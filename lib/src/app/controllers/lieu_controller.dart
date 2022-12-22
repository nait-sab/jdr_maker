import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:provider/provider.dart';

/// Classe : Lieu
///
/// Type : Controller
///
/// Contient le lieu actuel
class LieuController extends ChangeNotifier {
  /// Projet sélectionné
  LieuModel? lieu;

  void _actualiser(LieuModel lieu) {
    this.lieu = lieu;
    notifyListeners();
  }

  static void changerLieu(BuildContext context, LieuModel lieu) {
    Provider.of<LieuController>(context, listen: false)._actualiser(lieu);
  }
}
