/// Classe : Objet
///
/// Type : Model
///
/// Modèle des objets
class ObjetModel {
  static String nomCollection = "Objets";

  String id;
  String idCreateur;
  String idProjet;
  String nomObjet;

  ObjetModel({
    required this.id,
    required this.idCreateur,
    required this.idProjet,
    required this.nomObjet,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "nomObjet": nomObjet,
    };
  }

  static ObjetModel fromMap(data) {
    return ObjetModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      idProjet: data["idProjet"],
      nomObjet: data["nomObjet"],
    );
  }
}
