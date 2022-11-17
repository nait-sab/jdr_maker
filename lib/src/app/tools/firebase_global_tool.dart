import 'dart:io';

import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';
import 'package:jdr_maker/src/domain/models/evenement_model.dart';

/// Classe : Firebase Global
///
/// Type : Tool
///
/// Permet d'appeler les fonctions des outils Firebase en gérant automatiquement le support
class FirebaseGlobalTool {
  /// Récupérer une liste d'élément par le [nomCollection] suivi de l'[action] à réaliser sur le json récupérer
  static Future recupererListe(String nomCollection, Function action) async {
    return Platform.isAndroid
        ? await FirebaseAndroidTool.getListeCollection(nomCollection, action)
        : await FirebaseDesktopTool.getListeCollection(nomCollection, action);
  }

  // Modifier un document en gérant automatiquement le support
  // Nécéssite le [nomCollection], l'[id] du document et le [json] du model
  static Future modifierDocument(String nomCollection, String id, Map<String, dynamic> json) async {
    return Platform.isAndroid
        ? await FirebaseAndroidTool.modifierDocument(EvenementModel.nomCollection, id, json)
        : await FirebaseDesktopTool.modifierDocument(EvenementModel.nomCollection, id, json);
  }
}
