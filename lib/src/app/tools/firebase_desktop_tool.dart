import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';

/// Classe : Firebase Desktop
///
/// Type : Tool
///
/// Contient les fonctions de manipulation Firebase pour le support Desktop
class FirebaseDesktopTool {
  // =============================================================
  // Instance Firebase
  // =============================================================
  /// Récupérer l'instance d'une collection par son [nom]
  static CollectionReference _getInstanceCollection(String nom) {
    return Firestore.instance.collection(nom);
  }

  /// Récupérer l'instance du module Auth
  static FirebaseAuth _getAuthInstance() {
    return FirebaseAuth.instance;
  }

  // =============================================================
  // Fonctions Firestore
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

  // =============================================================
  // Fonctions Auth
  // =============================================================
  /// Créer un nouveau compte à partir d'un [mail] et d'un [passe]
  static Future creerCompte(String mail, String passe) async {
    await _getAuthInstance().signUp(mail, passe);
  }

  /// Se connecter à un compte à partir d'un [mail] et d'un [passe]
  static Future connexion(String mail, String passe) async {
    await _getAuthInstance().signIn(mail, passe);
  }

  /// Récupérer l'utilisateur connecter actuellement
  static Future<User> getUtilisateur() async {
    return await _getAuthInstance().getUser();
  }

  /// Déconnecter l'utilisateur
  /// Si besoin de modifier la page dû au changement, éffectuer un await de getUtilisateur()
  static void deconnexion() {
    _getAuthInstance().signOut();
  }
}