import 'package:flutter/material.dart';

/// Classe : Projet
///
/// Type : Model
///
/// Contient les variables d'un projet JDRw
class ProjetModel extends ChangeNotifier {
  String id;
  String idCreateur;
  String nomProjet;

  ProjetModel({
    required this.id,
    required this.idCreateur,
    required this.nomProjet,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "nomProjet": nomProjet,
    };
  }
}
