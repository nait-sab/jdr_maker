import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class ConnexionFormulaire extends StatelessWidget {
  final List<Widget> contenu;

  ConnexionFormulaire({
    required this.contenu,
  });

  @override
  Widget build(BuildContext context) {
    Size ecran = MediaQuery.of(context).size;
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: Platform.isAndroid ? ecran.width * 0.9 : ecran.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Couleurs.fondSecondaire,
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: contenu,
            ),
          ),
        ),
      ),
    );
  }
}
