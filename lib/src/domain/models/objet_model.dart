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
  String lienImage;
  String description;

  ObjetModel(
      {required this.id,
      required this.idCreateur,
      required this.idProjet,
      required this.nomObjet,
      required this.lienImage,
      required this.description});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idCreateur": idCreateur,
      "idProjet": idProjet,
      "nomObjet": nomObjet,
      "lienImage": lienImage,
      "description": description
    };
  }

  static ObjetModel fromMap(data) {
    return ObjetModel(
        id: data["id"],
        idCreateur: data["idCreateur"],
        idProjet: data["idProjet"],
        nomObjet: data["nomObjet"],
        lienImage: data["lienImage"],
        description: data["description"]);
  }
}
