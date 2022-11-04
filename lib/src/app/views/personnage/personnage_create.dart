import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/widgets/interface/app_interface.dart';
import 'package:jdr_maker/src/domain/data/couleurs.dart';

class PersonnageView extends StatefulWidget {
  const PersonnageView({super.key});

  @override
  State<PersonnageView> createState() => _PersonnageViewState();
}

class _PersonnageViewState extends State<PersonnageView> {
  @override
  Widget build(BuildContext context) {
    return AppInterface(
      child: SingleChildScrollView(
          child: Container(
        color: Couleurs.fondSecondaire,
        child: Column(children: [Text("")]),
      )),
    );
  }
}
