import 'package:eight_puzzle_game/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: '8 Puzzle problem',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Game(),
  ));
}