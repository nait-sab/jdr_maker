import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/views/accueil_view.dart';
import 'package:jdr_maker/src/app/views/connexion/connexion_view.dart';
import 'package:jdr_maker/src/app/views/connexion/inscription_view.dart';
import 'package:jdr_maker/src/app/views/creerJDR/debut_jdr_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenement_create_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenement_edit_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenement_view.dart';
import 'package:jdr_maker/src/app/views/evenements/evenements_view.dart';
import 'package:jdr_maker/src/app/views/lieux/lieu_create.dart';
import 'package:jdr_maker/src/app/views/lieux/lieu_edit.dart';
import 'package:jdr_maker/src/app/views/lieux/lieu_view.dart';
import 'package:jdr_maker/src/app/views/lieux/lieux_view.dart';
import 'package:jdr_maker/src/app/views/objets/objet_create.dart';
import 'package:jdr_maker/src/app/views/objets/objet_edit.dart';
import 'package:jdr_maker/src/app/views/objets/objet_view.dart';
import 'package:jdr_maker/src/app/views/objets/objets_view.dart';
import 'package:jdr_maker/src/app/views/options/options_view.dart';
import 'package:jdr_maker/src/app/views/personnage/personnage_create.dart';
import 'package:jdr_maker/src/app/views/personnage/personnage_edit.dart';
import 'package:jdr_maker/src/app/views/personnage/personnage_view.dart';
import 'package:jdr_maker/src/app/views/personnage/personnages_view.dart';
import 'package:jdr_maker/src/app/views/profil/profil_view.dart';
import 'package:jdr_maker/src/app/views/rechercher/rechercher_view.dart';
import 'package:jdr_maker/src/app/widgets/lance_des.dart';
import 'package:provider/provider.dart';

/// Liste des pages de l'application
///
/// Le rooting s'éffectue selon la route
/// actuelle du controller navigation
///
/// Routes actuelles :
///
/// - / (accueil)
/// - /connexion
/// - /inscription
List<Page> applicationRoutes(context) {
  NavigationController navigation = Provider.of<NavigationController>(context);
  List<Page> liste = [];

  // Route par défaut
  liste.add(MaterialPage(child: ConnexionView()));

  // Routing
  // Toujours un / en début de route
  switch (navigation.currentRoute) {
    // =======================================================
    // Routes Connexion / Inscription
    // =======================================================
    case "/connexion":
      liste.add(MaterialPage(child: ConnexionView()));
      break;
    case "/inscription":
      liste.add(MaterialPage(child: InscriptionView()));
      break;
    case "/modifier_profil":
      liste.add(MaterialPage(child: EditProfileView()));
      break;

    // =======================================================
    // Routes de l'accueil
    // =======================================================
    case "/accueil":
      liste.add(MaterialPage(child: AccueilView()));
      break;
    case "/rechercher":
      liste.add(MaterialPage(child: RechercherView()));
      break;
    case "/options":
      liste.add(MaterialPage(child: OptionsView()));
      break;
    case "/creer_jdr":
      liste.add(MaterialPage(child: DebutJDR()));
      break;
    case "/jouer":
      //liste.add(MaterialPage(child: ));
      break;

    // =======================================================
    // Routes de l'application événement
    // =======================================================
    case "/evenements":
      liste.add(MaterialPage(child: EvenementsView()));
      break;
    case "/evenement":
      liste.add(MaterialPage(child: EvenementView()));
      break;
    case "/creer_evenement":
      liste.add(MaterialPage(child: EvenementCreateView()));
      break;
    case "/modifier_evenement":
      liste.add(MaterialPage(child: EvenementEditView()));
      break;

    // =======================================================
    // Routes de l'application personnage
    // =======================================================
    case "/personnages":
      liste.add(MaterialPage(child: PersonnagesView()));
      break;
    case "/personnage":
      liste.add(MaterialPage(child: PersonnageView()));
      break;
    case "/creer_personnage":
      liste.add(MaterialPage(child: PersonnageCreate()));
      break;
    case "/modifier_personnage":
      liste.add(MaterialPage(child: PersonnageEdit()));
      break;

    // =======================================================
    // Routes de l'application objet
    // =======================================================
    case "/objets":
      liste.add(MaterialPage(child: ObjetsView()));
      break;
    case "/objet":
      liste.add(MaterialPage(child: ObjetView()));
      break;
    case "/creer_objet":
      liste.add(MaterialPage(child: ObjetCreate()));
      break;
    case "/modifier_objet":
      liste.add(MaterialPage(child: ObjetEdit()));
      break;

    // =======================================================
    // Routes de l'application lieu
    // =======================================================
    case "/lieux":
      liste.add(MaterialPage(child: LieuxView()));
      break;
    case "/lieu":
      liste.add(MaterialPage(child: LieuView()));
      break;
    case "/creer_lieu":
      liste.add(MaterialPage(child: LieuCreate()));
      break;
    case "/modifier_lieu":
      liste.add(MaterialPage(child: LieuEdit()));
      break;

    // =======================================================
    // Test de lancé de dés
    // =======================================================
    case "/lance":
      liste.add(MaterialPage(child: LanceDes()));
      break;
  }

  return liste;
}
