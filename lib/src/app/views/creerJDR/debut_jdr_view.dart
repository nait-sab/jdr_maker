import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/views/creerJDR/widgets/debut_jdr_widgets.dart';

/// Classe DebutJDR
///
/// Type : View
///
/// TODO - Description à écrire
class DebutJDR extends StatefulWidget {
  @override
  State<DebutJDR> createState() => _DebutJDRState();
}

class _DebutJDRState extends State<DebutJDR> {
  // TODO - Variables à initialiser en init State, jamais en brute + late avant la variable déclaré
  String bullet = "\u2022 ";
  int etape = 0;

  @override
  void initState() {
    super.initState();
    etape = 1;
  }

  void gestionEtape() {
    setState(() {
      etape++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e1e1e),
      body: etape == 1
          ? DebutJDRWidgets.rendu1(context, bullet, gestionEtape)
          : DebutJDRWidgets.rendu2(context),
    );
  }
}
