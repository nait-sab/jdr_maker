import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Classe Accueil
///
/// Type : View
///
/// Page par défaut actuelle de l'application
class DebutJDR extends StatefulWidget {
  @override
  State<DebutJDR> createState() => _DebutJDRState();
}

class _DebutJDRState extends State<DebutJDR> {
  String bullet = "\u2022 ";
  int etape = 0;
  @override
  void initState() {
    super.initState();
    etape = 1;
    // Vérification si l'utilisateur est connecté
    // if !connecter
    //  NavigationController.changerView(context, "/connexion");

    // Affichage de l'interface selon les données user
    // La gestion ne doit pas apparaître si aucun JDR est lié à l'user
  }

  gestionEtape() {
    setState(() {
      etape++;
    });

    initFirebase() {
      print('init firebase');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1e1e1e),
        body: etape == 1 ? rendu1(context) : rendu2(context));
  }

  Widget rendu1(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 100,
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Dés part',
             style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
              ),
              Text(
                ", Créateur de JDR",
                style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: 100,
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${bullet}Événements...",
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    "${bullet}Personnages....",
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    "${bullet}Lieux...",
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
              InkWell(
                onTap: gestionEtape,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
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
                      Text("Commencer",
                       style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                          textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget rendu2(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("Donnez un nom à votre JDR:")],
    );
  }
}
