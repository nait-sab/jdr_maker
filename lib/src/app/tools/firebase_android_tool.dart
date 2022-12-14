import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  /// Récupérer l'instance du module Auth
  static FirebaseAuth _getAuthInstance() {
    return FirebaseAuth.instance;
  }

  // =============================================================
  // Fonctions Firestore
  // =============================================================
  /// Récupérer la liste des documents d'une collection
  static Future<QuerySnapshot<Object?>> getCollection(String nom) async {
    return await _getInstanceCollection(nom).get();
  }

  /// Récupérer le json d'un élément de collection par son ID
  static Future getdocumentID(String nomCollection, String id) async {
    return await _getInstanceCollection(nomCollection).doc(id).get();
  }

  /// Récupérer une collection vers une liste
  static Future getListeCollection(String nomCollection, Function action) async {
    var collection = await getCollection(nomCollection);
    var liste = collection.docs.map((document) => document.data()).toList();
    for (var data in liste) {
      action(data);
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
    return await _getInstanceCollection(collection).doc(id).set(json);
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

  // =============================================================
  // Fonctions Auth
  // =============================================================
  /// Créer un nouveau compte à partir d'un [mail] et d'un [passe]
  static Future<bool> creerCompte(String mail, String passe) async {
    try {
      await _getAuthInstance().createUserWithEmailAndPassword(email: mail, password: passe);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  /// Se connecter à un compte à partir d'un [mail] et d'un [passe]
  static Future<bool> connexion(String mail, String passe) async {
    try {
      await _getAuthInstance().signInWithEmailAndPassword(email: mail, password: passe);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  /// Récupérer l'utilisateur connecter actuellement
  /// Voir https://firebase.flutter.dev/docs/auth/start authStateChanges()
  static User? getUtilisateur() {
    return _getAuthInstance().currentUser;
  }

  static Stream<User?> getChangementAuthentification() {
    return _getAuthInstance().authStateChanges();
  }

  /// Déconnecter l'utilisateur
  /// Si besoin de modifier la page dû au changement, éffectuer un await de getUtilisateur()
  static Future deconnexion() async {
    await _getAuthInstance().signOut();
  }

  /// Changer le mot de [passe] de l'utilisateur
  static Future changerCompte(String passe) async {
    await _getAuthInstance().currentUser!.updatePassword(passe);
  }
}
