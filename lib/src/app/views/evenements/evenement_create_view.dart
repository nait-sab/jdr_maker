import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';

/// Classe : Événement
///
/// Type : View
///
/// Afficher la création d'un nouvel événement
class EvenementCreateView extends StatefulWidget {
  @override
  State<EvenementCreateView> createState() => _EvenementCreateViewState();
}

class _EvenementCreateViewState extends State<EvenementCreateView> {
  @override
  Widget build(BuildContext context) {
    return AppInterface(child: Center(child: Text("creation")));
  }
}
