import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Classe : Debut JDR
///
/// Type : Widgets
///
/// Contient les widgets utilisés par la view
class DebutJDRWidgets {
  static Widget rendu1(
      BuildContext context, String bullet, VoidCallback gestionEtape) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: MediaQuery.of(context).size.width * 0.2,
            right: MediaQuery.of(context).size.width * 0.2,
          ),
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
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 100,
            left: MediaQuery.of(context).size.width * 0.2,
            right: MediaQuery.of(context).size.width * 0.2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$bulletÉvénements...",
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
                      Text(
                        "Commencer",
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height * 0.05,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget rendu2(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Donnez un nom à votre JDR:",
        ),
      ],
    );
  }
}
