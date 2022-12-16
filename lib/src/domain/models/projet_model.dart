import 'dart:ffi';

/// Classe : Projet
///
/// Type : Model
///
/// Modèle des projets
class ProjetModel {
  static String nomCollection = "Projets";

  String id;
  String idCreateur;
  String nomProjet;
  bool isPublic;

  ProjetModel({required this.id, required this.idCreateur, required this.nomProjet, required this.isPublic});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "nomProjet": nomProjet,
      "isPublic": isPublic,
    };
  }

  static ProjetModel fromMap(data) {
    return ProjetModel(
        id: data["id"], idCreateur: data["idCreateur"], nomProjet: data["nomProjet"], isPublic: data["isPublic"]);
  }
}
