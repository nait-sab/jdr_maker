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
  String nomEvenement;

  EvenementModel({
    required this.id,
    required this.idCreateur,
    required this.idProjet,
    required this.nomEvenement,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "nomEvenement": nomEvenement,
    };
  }

  static EvenementModel fromMap(data) {
    return EvenementModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      idProjet: data["idProjet"],
      nomEvenement: data["nomEvenement"],
    );
  }
}
