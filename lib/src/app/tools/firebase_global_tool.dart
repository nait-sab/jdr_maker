import 'dart:io';

import 'package:jdr_maker/src/app/tools/firebase_android_tool.dart';
import 'package:jdr_maker/src/app/tools/firebase_desktop_tool.dart';

/// Classe : Firebase Global
///
/// Type : Tool
///
/// Permet d'appeler les fonctions des outils Firebase en gérant automatiquement le support
class FirebaseGlobalTool {
  static Future recupererListe(String nomCollection, Function action) async {
    return Platform.isAndroid
        ? await FirebaseAndroidTool.getListeCollection(nomCollection, action)
        : await FirebaseDesktopTool.getListeCollection(nomCollection, action);
  }
}
