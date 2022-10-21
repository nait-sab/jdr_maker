import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';

/// Classe : Accueil
///
/// Type : Widgets
///
/// Contient les widgets utilisés par la view
class AccueilWidgets {
  static Widget renduChargement(BuildContext context) {
    return Container(
      color: Color(0xff1e1e1e),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget renduDesktop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () =>
                  NavigationController.changerView(context, "/creer_jdr"),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: Color(0xff81818f),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 15,
                      blurRadius: 60,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Création JDR",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  NavigationController.changerView(context, "/inscription"),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: Color(0xff81818f),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 15,
                      blurRadius: 60,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Inscription",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  static Widget renduAndroid(BuildContext context) {
    return Container();
  }
}
