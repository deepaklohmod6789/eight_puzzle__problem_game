import 'package:eight_puzzle_game/classes/tile.dart';
import 'package:flutter/material.dart';

class Direction{
  int maxRows;
  late Tile tile;

  Direction(this.maxRows){
    tile=Tile(maxRows);
  }

  DismissDirection forVerticalDismiss(int index){
    if(tile.isInFirstRow(index)) {
      return DismissDirection.down;
    } else if(tile.isInLastRow(index)) {
      return DismissDirection.up;
    } else {
      return DismissDirection.vertical;
    }
  }

  DismissDirection forHorizontalDismiss(int index){
    if(tile.isInFirstColumn(index)) {
      return DismissDirection.startToEnd;
    } else if(tile.isInLastColumn(index)) {
      return DismissDirection.endToStart;
    } else {
      return DismissDirection.horizontal;
    }
  }

}