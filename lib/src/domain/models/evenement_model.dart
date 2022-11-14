/// Classe : Evenenement
///
/// Type : Model
///
/// Modèle des événements
class EvenementModel {
  static String nomCollection = "Evenements";

  String id;
  String idCreateur;
  String idProjet;
  String numero;
  String nom;
  String description;

  EvenementModel({
    required this.id,
    required this.idCreateur,
    required this.idProjet,
    required this.numero,
    required this.nom,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "numero": numero,
      "nom": nom,
      "description": description,
    };
  }

  static EvenementModel fromMap(data) {
    return EvenementModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      idProjet: data["idProjet"],
      numero: data["numero"],
      nom: data["nom"],
      description: data["description"],
    );
  }
}
