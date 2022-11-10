import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:provider/provider.dart';

class PersonnageView extends StatefulWidget {
  const PersonnageView({super.key});

  @override
  State<PersonnageView> createState() => _PersonnageViewState();
}

class _PersonnageViewState extends State<PersonnageView> {
  late ProjetController projetController;
  // late QuillController _controller;

  @override
  void initState() {
    super.initState();
  }

  void leave() {
    NavigationController.changerView(context, "/personnages");
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    return AppInterface(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Couleurs.fondSecondaire),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: 100,
                            maxWidth: 200,
                            maxHeight: 200,
                            minHeight: 100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                projetController.personnage!.lienImage != ""
                                    ? projetController.personnage!.lienImage
                                    : 'https://picsum.photos/200/300',
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Column(
                          children: [
                            Text(
                              projetController.personnage!.nomPersonnage,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Couleurs.texte,
                                  fontSize: 50),
                            ),
                            Text(
                              projetController.personnage!.prenomPersonnage,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Couleurs.texte,
                                  fontSize: 50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Couleurs.texte,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Couleurs.fondPrincipale),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      projetController.personnage!.description,
                      style: TextStyle(
                        color: Couleurs.texte,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Histoire",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Couleurs.texte,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Couleurs.fondPrincipale),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      projetController.personnage!.histoire,
                      style: TextStyle(
                        color: Couleurs.texte,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: leave, child: Text("Retour")),
              )
            ],
          ),
        ),
      )),
    );
  }
}
