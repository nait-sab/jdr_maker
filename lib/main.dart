import 'package:flutter/material.dart';
import 'package:jdr_maker/src/app/app.dart';
import 'package:jdr_maker/src/app/controllers/navigation_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationController>(
            create: (_) => NavigationController()),
      ],
      child: App(),
    ),
  );
}
