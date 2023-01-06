import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdr_maker/src/app/tools/get_random_nb.dart';
import 'package:jdr_maker/src/app/widgets/champs/champ_saisie.dart';
import 'package:jdr_maker/src/app/widgets/entete_application.dart';
import 'package:jdr_maker/src/app/widgets/interfaces/app_interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class LanceDes extends StatefulWidget {
  const LanceDes({super.key});

  @override
  State<LanceDes> createState() => _LanceDesState();
}

class _LanceDesState extends State<LanceDes> {
  double turns = 0;
  late TextEditingController textEditingControllerNbMAX;
  late String nb;
  late bool premierlancer = true;
  @override
  void initState() {
    super.initState();
    textEditingControllerNbMAX = TextEditingController();
  }

  void _changeRotation() {
    setState(() => turns += 3.0);
  }

  void getResultat() {
    if (textEditingControllerNbMAX.text.isNotEmpty) {
      setState(() {
        nb = next(int.parse(textEditingControllerNbMAX.text)).toString();
        premierlancer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppInterface(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            EnteteApplication(routeRetour: "/accueil", titreFormulaire: "Test lancé de dés"),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Couleurs.fondSecondaire),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedRotation(
                            turns: turns,
                            duration: const Duration(seconds: 1),
                            onEnd: getResultat,
                            child: Icon(
                              Icons.check_box_outline_blank,
                              size: 60,
                              color: Couleurs.violet,
                            )),
                        if (!premierlancer)
                          Text(
                            nb,
                            style: TextStyle(color: Couleurs.texte, fontSize: 25),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 100,
                            child: ChampSaisie(
                              nomChamp: "Max",
                              couleurTexte: Couleurs.texte,
                              typeChamp: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: textEditingControllerNbMAX,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
                            onPressed: _changeRotation,
                            child: const Text('Lancer les dés'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
