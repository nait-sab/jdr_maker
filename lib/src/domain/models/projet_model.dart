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

  static ProjetModel fromMap(data) {
    return ProjetModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      nomProjet: data["nomProjet"],
    );
  }
}
