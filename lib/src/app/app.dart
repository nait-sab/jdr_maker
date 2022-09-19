import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:jdr_maker/src/app/routes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: applicationRoutes(context),
        onPopPage: (route, resultat) {
          bool popStatus = route.didPop(resultat);
          if (popStatus) {
            Provider.of<NavigationController>(context, listen: false)
                .changerRoute("/");
          }
          return popStatus;
        },
      ),
    );
  }
}
