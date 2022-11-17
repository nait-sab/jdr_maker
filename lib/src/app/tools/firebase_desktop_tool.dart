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
  static Future creerCompte(String mail, String passe) async {
    await _getAuthInstance().signUp(mail, passe);
  }

  /// Se connecter à un compte à partir d'un [mail] et d'un [passe]
  static Future connexion(String mail, String passe) async {
    await _getAuthInstance().signIn(mail, passe);
  }

  /// Récupérer l'utilisateur connecter actuellement
  static Future<User?> getUtilisateur() async {
    bool connexionActive = _getAuthInstance().isSignedIn;
    return connexionActive ? _getAuthInstance().getUser() : null;
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
}
