import 'dart:math';
final _random = Random();

/// Genere un nb aléatoire
int next(int max) => 1 + _random.nextInt((max+1) - 1);
