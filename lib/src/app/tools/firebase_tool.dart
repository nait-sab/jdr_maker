import 'package:firedart/firedart.dart';

/// Classe : Firebase Desktop
///
/// Type : Tool
///
/// Contient les fonctions de manipulation Firebase pour le support Desktop
class FirebaseDesktopTool {
  /// Récupérer l'instance d'une collection par son nom
  static CollectionReference _getInstanceCollection(String nom) {
    return Firestore.instance.collection(nom);
  }

  // =============================================================
  // Fonctions liés à Firestore
  // =============================================================

  /// Récupérer la liste des documents d'une collection
  static Future<Page<Document>> getCollection(String nom) async {
    return await _getInstanceCollection(nom).get();
  }

  /// Ajouter un nouveau document à une [collection] contenant les données [json]
  static Future ajouterDocument(
    String collection,
    Map<String, dynamic> json,
  ) async {
    return await _getInstanceCollection(collection).add(json);
  }

  /// Modifier le [document] de la [collection] par les données [json]
  static Future modifierDocument(
    String collection,
    String document,
    Map<String, dynamic> json,
  ) async {
    return await _getInstanceCollection(collection)
        .document(document)
        .update(json);
  }

  /// Supprimer le [document] de la [collection]
  static Future supprimerDocument(String collection, String document) async {
    return await _getInstanceCollection(collection).document(document).delete();
  }
}
