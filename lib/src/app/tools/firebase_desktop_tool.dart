import 'package:firedart/auth/exceptions.dart';
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

  /// Récupérer le json d'un élément de collection par son ID
  static Future getdocumentID(String nomCollection, String id) async {
    return await _getInstanceCollection(nomCollection).document(id).get();
  }

  /// Récupérer une collection vers une liste
  static Future getListeCollection(String nomCollection, Function action) async {
    var collection = await getCollection(nomCollection);
    for (var document in collection) {
      action(document.map);
    }
  }

  /// Ajouter un nouveau document à une [collection] contenant les données [json]
  static Future ajouterDocument(
    String collection,
    Map<String, dynamic> json,
  ) async {
    return await _getInstanceCollection(collection).add(json);
  }

  /// Ajouter un nouveau document par un [id] à une [collection] contenant les données [json]
  static Future ajouterDocumentID(
    String collection,
    String id,
    Map<String, dynamic> json,
  ) async {
    return await _getInstanceCollection(collection).document(id).set(json);
  }

  /// Modifier le [document] de la [collection] par les données [json]
  static Future modifierDocument(
    String collection,
    String document,
    Map<String, dynamic> json,
  ) async {
    return await _getInstanceCollection(collection).document(document).update(json);
  }

  /// Supprimer le [document] de la [collection]
  static Future supprimerDocument(String collection, String document) async {
    return await _getInstanceCollection(collection).document(document).delete();
  }

  // =============================================================
  // Fonctions Auth
  // =============================================================
  /// Créer un nouveau compte à partir d'un [mail] et d'un [passe]
  static Future<bool> creerCompte(String mail, String passe) async {
    try {
      await _getAuthInstance().signUp(mail, passe);
      return true;
    } on AuthException {
      return false;
    }
  }

  /// Se connecter à un compte à partir d'un [mail] et d'un [passe]
  static Future<bool> connexion(String mail, String passe) async {
    try {
      await _getAuthInstance().signIn(mail, passe);
      return true;
    } on AuthException {
      return false;
    }
  }

  /// Récupérer l'utilisateur connecter actuellement
  static Future<User?> getUtilisateur() async {
    return await _getAuthInstance().getUser();
  }

  /// Récupérer l'utilisateur connecter actuellement
  static String getUtilisateurID() {
    return _getAuthInstance().userId;
  }

  static Future<void> changePass(String password) {
    return _getAuthInstance().changePassword(password);
  }

  /// Déconnecter l'utilisateur
  /// Si besoin de modifier la page dû au changement, éffectuer un await de getUtilisateur()
  static void deconnexion() {
    _getAuthInstance().signOut();
  }

  /// Changer le mot de [passe] de l'utilisateur
  static Future changerCompte(String passe) async {
    await _getAuthInstance().changePassword(passe);
  }
}
