import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/utilisateur_controller.dart';
import 'package:jdr_maker/src/app/tools/firebase_global_tool.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';
import 'package:jdr_maker/src/domain/models/lieu_model.dart';
import 'package:jdr_maker/src/domain/models/objet_model.dart';
import 'package:jdr_maker/src/domain/models/personnage_model.dart';
import 'package:jdr_maker/src/domain/models/projet_model.dart';
import 'package:jdr_maker/src/domain/models/utilisateur_model.dart';
import 'package:provider/provider.dart';

/// Classe : Projet
///
/// Type : Controller
///
/// Contient le projet actuel dans l'application
class ProjetController extends ChangeNotifier {
  /// Liste des projets
  List<ProjetModel> projets = [];

  /// Données du projet actuel
  ProjetModel? projet;
  List<EvenementModel>? evenements;
  List<PersonnageModel>? personnages;
  List<LieuModel>? lieux;
  List<ObjetModel>? objets;

  // =========================================================
  // Actualiser le projet
  // =========================================================
  Future _actualiser() async {
    // Changer le projet actuel et réinitialiser les applications liées
    if (projet == null) {
      return;
    }
    evenements = await _chargerEvenements(projet!);
    personnages = await _chargerPersonnages(projet!);
    lieux = await _chargerLieux(projet!);
    objets = await _chargerObjets(projet!);
    print("actualisation terminé");
    notifyListeners();
  }

  /// Actualiser le [projet] actuel
  static Future actualiserProjet(BuildContext context) async {
    await Provider.of<ProjetController>(context, listen: false)._actualiser();
  }

  // =========================================================
  // Changer de projet
  // =========================================================
  Future _chargerProjet(ProjetModel projet) async {
    // Changer le projet actuel et réinitialiser les applications liées
    this.projet = projet;
    evenements = await _chargerEvenements(projet);
    personnages = await _chargerPersonnages(projet);
    lieux = await _chargerLieux(projet);
    objets = await _chargerObjets(projet);
    print("chargement terminé");
    notifyListeners();
  }

  /// Charger les evenements du [projet]
  Future<List<EvenementModel>> _chargerEvenements(ProjetModel projet) async {
    List<EvenementModel> liste = [];
    await FirebaseGlobalTool.recupererListe(EvenementModel.nomCollection, (data) {
      EvenementModel evenement = EvenementModel.fromMap(data);
      if (evenement.idProjet == projet.id) {
        liste.add(evenement);
      }
    });
    return liste;
  }

  /// Charger les personnages du [projet]
  Future<List<PersonnageModel>> _chargerPersonnages(ProjetModel projet) async {
    List<PersonnageModel> liste = [];
    await FirebaseGlobalTool.recupererListe(PersonnageModel.nomCollection, (data) {
      PersonnageModel personnage = PersonnageModel.fromMap(data);
      if (personnage.idProjet == projet.id) {
        liste.add(personnage);
      }
    });
    return liste;
  }

  /// Charger les lieux du [projet]
  Future<List<LieuModel>> _chargerLieux(ProjetModel projet) async {
    List<LieuModel> liste = [];
    await FirebaseGlobalTool.recupererListe(LieuModel.nomCollection, (data) {
      LieuModel lieu = LieuModel.fromMap(data);
      if (lieu.idProjet == projet.id) {
        liste.add(lieu);
      }
    });
    return liste;
  }

  /// Charger les objets du [projet]
  Future<List<ObjetModel>> _chargerObjets(ProjetModel projet) async {
    List<ObjetModel> liste = [];
    await FirebaseGlobalTool.recupererListe(ObjetModel.nomCollection, (data) {
      ObjetModel objet = ObjetModel.fromMap(data);
      if (objet.idProjet == projet.id) {
        liste.add(objet);
      }
    });
    return liste;
  }

  /// Charger ou changer le [projet] actuel
  static Future chargerProjet(BuildContext context, ProjetModel projet) async {
    await Provider.of<ProjetController>(context, listen: false)._chargerProjet(projet);
  }

  // =========================================================
  // Charger les projets
  // =========================================================
  /// Charger les projets lié à l'[utilisateur]
  Future _chargerProjets(UtilisateurModel utilisateur) async {
    // Réinitialiser le contenu actuel
    projets = [];
    projet = null;
    evenements = null;
    personnages = null;
    lieux = null;
    objets = null;

    // Récupérer la liste des projets Firebase
    await FirebaseGlobalTool.recupererListe(ProjetModel.nomCollection, (data) {
      ProjetModel projetModel = ProjetModel.fromMap(data);
      if (projetModel.idCreateur == utilisateur.id) {
        projets.add(projetModel);
      }
    });

    // Mettre à jour les interfaces
    notifyListeners();
  }

  /// Charger les projets lié au compte
  static Future chargerProjets(BuildContext context) async {
    UtilisateurModel utilisateur = UtilisateurController.getUtilisateur(context);
    await Provider.of<ProjetController>(context, listen: false)._chargerProjets(utilisateur);
  }

  // =========================================================
  // Supprimer le projet
  // =========================================================
  Future _supprimer() async {
    // Changer le projet actuel et réinitialiser les applications liées
    if (projet == null) {
      return;
    }

    // Supprimer l'ensemble des données liées au projet
    if (evenements!.isNotEmpty) {
      for (EvenementModel evenement in evenements!) {
        await FirebaseGlobalTool.supprimerDocument(EvenementModel.nomCollection, evenement.id);
      }
    }

    if (personnages!.isNotEmpty) {
      for (PersonnageModel personnage in personnages!) {
        await FirebaseGlobalTool.supprimerDocument(PersonnageModel.nomCollection, personnage.id);
      }
    }

    if (lieux!.isNotEmpty) {
      for (LieuModel lieu in lieux!) {
        await FirebaseGlobalTool.supprimerDocument(LieuModel.nomCollection, lieu.id);
      }
    }

    if (objets!.isNotEmpty) {
      for (ObjetModel objet in objets!) {
        await FirebaseGlobalTool.supprimerDocument(ObjetModel.nomCollection, objet.id);
      }
    }

    await FirebaseGlobalTool.supprimerDocument(ProjetModel.nomCollection, projet!.id);
  }

  /// supprimer le [projet] actuel
  static Future supprimerProjet(BuildContext context) async {
    UtilisateurModel utilisateur = UtilisateurController.getUtilisateur(context);
    ProjetController projetController = Provider.of<ProjetController>(context, listen: false);

    // Vérifier que le projet contient la totalité des donnéés avant de le supprimer
    await projetController._actualiser();
    await projetController._supprimer();

    // Récupérer à nouveau les données de l'utilisateur
    await projetController._chargerProjets(utilisateur);
  }

  // =========================================================
  // Getters
  // =========================================================
  /// Récupérer les evenements du projet sans listener
  static List<EvenementModel> getEvenements(BuildContext context) {
    return Provider.of<ProjetController>(context, listen: false).evenements ?? [];
  }

  /// Récupérer les personnages du projet sans listener
  static List<PersonnageModel> getPersonnages(BuildContext context) {
    return Provider.of<ProjetController>(context, listen: false).personnages ?? [];
  }

  /// Récupérer les evenements du projet sans listener
  static List<LieuModel> getLieux(BuildContext context) {
    return Provider.of<ProjetController>(context, listen: false).lieux ?? [];
  }

  /// Récupérer les evenements du projet sans listener
  static List<ObjetModel> getObjets(BuildContext context) {
    return Provider.of<ProjetController>(context, listen: false).objets ?? [];
  }
}
