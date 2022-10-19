import 'package:cloud_firestore/cloud_firestore.dart';

/// Classe : Firebase Android
///
/// Type : Tool
///
/// Contient les fonctions de manipulation Firebase pour le support Android
class FirebaseAndroidTool {
  // =============================================================
  // Instance Firebase
  // =============================================================
  /// Récupérer l'instance d'une collection par son [nom]
  static CollectionReference _getInstanceCollection(String nom) {
    return FirebaseFirestore.instance.collection(nom);
  }

  // =============================================================
  // Fonctions Firestore
  // =============================================================
  /// Récupérer la liste des documents d'une collection
  static Future<QuerySnapshot<Object?>> getCollection(String nom) async {
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
    return await _getInstanceCollection(collection).doc(document).update(json);
  }

  /// Supprimer le [document] de la [collection]
  static Future supprimerDocument(String collection, String document) async {
    return await _getInstanceCollection(collection).doc(document).delete();
  }
}
