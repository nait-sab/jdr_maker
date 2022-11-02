/// Classe : Personnage
///
/// Type : Model
///
/// Modèle des personnages
class PersonnageModel {
  static String nomCollection = "Personnages";

  String id;
  String idCreateur;
  String idProjet;
  String nomPersonnage;

  PersonnageModel({
    required this.id,
    required this.idCreateur,
    required this.idProjet,
    required this.nomPersonnage,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "nomPersonnage": nomPersonnage,
    };
  }

  static PersonnageModel fromMap(data) {
    return PersonnageModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      idProjet: data["idProjet"],
      nomPersonnage: data["nomPersonnage"],
    );
  }
}
