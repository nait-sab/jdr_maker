/// Classe : Membre
///
/// Type : Model
///
/// Membre d'un projet
class MembreModel {
  static String nomCollection = "Membres";

  String id;
  String idProjet;
  String idMembre;

  MembreModel({
    required this.id,
    required this.idProjet,
    required this.idMembre,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProjet": idProjet,
      "idMembre": idMembre,
    };
  }

  static MembreModel fromMap(data) {
    return MembreModel(
      id: data["id"],
      idProjet: data["idProjet"],
      idMembre: data["idMembre"],
    );
  }
}
