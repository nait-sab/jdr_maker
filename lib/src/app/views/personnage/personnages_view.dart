import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/projet_controller.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';
import 'package:provider/provider.dart';

class PersonnagesView extends StatefulWidget {
  @override
  State<PersonnagesView> createState() => _PersonnagesViewState();
}

class _PersonnagesViewState extends State<PersonnagesView> {
  late ProjetController projetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    projetController = Provider.of<ProjetController>(context);
    Size ecran = MediaQuery.of(context).size;
    return AppInterface(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: projetController.personnages?.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Couleurs.fondSecondaire),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: 100,
                                maxWidth: 170,
                                maxHeight: 170,
                                minHeight: 100),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://picsum.photos/200/300',
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              projetController
                                  .personnages![index].nomPersonnage,
                              style: TextStyle(color: Couleurs.texte),
                            ),
                            Text(
                              projetController
                                  .personnages![index].prenomPersonnage,
                              style: TextStyle(color: Couleurs.texte),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
