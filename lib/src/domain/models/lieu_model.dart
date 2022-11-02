/// Classe : Lieu
///
/// Type : Model
///
/// Modèle des lieux
class LieuModel {
  static String nomCollection = "Lieux";

  String id;
  String idCreateur;
  String idProjet;
  String nomLieu;

  LieuModel({
    required this.id,
    required this.idCreateur,
    required this.idProjet,
    required this.nomLieu,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "nomLieu": nomLieu,
    };
  }

  static LieuModel fromMap(data) {
    return LieuModel(
      id: data["id"],
      idCreateur: data["idCreateur"],
      idProjet: data["idProjet"],
      nomLieu: data["nomLieu"],
    );
  }
}
