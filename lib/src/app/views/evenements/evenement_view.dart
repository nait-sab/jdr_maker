import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';

/// Classe : Événement
///
/// Type : View
///
/// Afficher l'événement sélectionner
class EvenementView extends StatefulWidget {
  @override
  State<EvenementView> createState() => _EvenementViewState();
}

class _EvenementViewState extends State<EvenementView> {
  @override
  Widget build(BuildContext context) {
    return AppInterface(child: Center(child: Text("bonjour")));
  }
}
