import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/tools/get_random_nb.dart';
import 'package:jdr_maker/src/app/widgets/champ.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:flutter/services.dart';

class LanceDes extends StatefulWidget {
  const LanceDes({super.key});

  @override
  State<LanceDes> createState() => _LanceDesState();
}

class _LanceDesState extends State<LanceDes> {
  double turns = 0.0;
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
    setState(() {
      nb = next(int.parse(textEditingControllerNbMAX.text)).toString();
      premierlancer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedRotation(
            turns: turns,
            duration: const Duration(seconds: 1),
            onEnd: getResultat,
            child: Icon(Icons.check_box_outline_blank,size: 50,color: Couleurs.violet,)),
        if (!premierlancer)
          Text(
            nb,
            style: TextStyle(color: Couleurs.texte, fontSize: 25),
          ),
        SizedBox(
          width: 100,
          child: Champ(
            couleurTexte: Couleurs.texte,
            typeChamp: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: textEditingControllerNbMAX,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Couleurs.violet),
            onPressed: _changeRotation,
            child: const Text('Lancer les dés'),
          ),
        ),
      ],
    );
  }
}
