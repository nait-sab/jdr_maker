import 'package:flutter/material.dart';

/// Classe : Personnage
///
/// Type : Model
///
/// Contient les variables d'un personnage de jdr
class PersonnageModel extends ChangeNotifier {
  static String nomCollection = "Personnages";

  String id;
  String idProjet;
  String nomPersonnage;
  String prenomPersonnage;
  String lienImage;
  String description;
  String histoire;

  PersonnageModel({
    required this.id,
    required this.idProjet,
    required this.nomPersonnage,
    required this.prenomPersonnage,
    required this.lienImage,
    required this.description,
    required this.histoire,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProjet": idProjet,
      "nomPersonnage": nomPersonnage,
      "prenomPersonnage": prenomPersonnage,
      "lienImage": lienImage,
      "description": description,
      "histoire": histoire,
    };
  }

  static PersonnageModel fromMap(data) {
    return PersonnageModel(
        id: data["id"],
        idProjet: data["idProjet"],
        nomPersonnage: data["nomPersonnage"],
        prenomPersonnage: data["prenomPersonnage"],
        lienImage: data["lienImage"],
        description: data["description"],
        histoire: data["histoire"]);
  }
}
