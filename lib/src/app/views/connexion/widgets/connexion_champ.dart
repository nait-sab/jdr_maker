import 'package:flutter/material.dart';

class ConnexionChamp extends StatelessWidget {
  final String nom;
  final TextEditingController controller;
  final bool secret;

  ConnexionChamp({
    required this.nom,
    required this.controller,
    bool? secret,
  }) : secret = secret ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            nom,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: secret,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: nom,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
