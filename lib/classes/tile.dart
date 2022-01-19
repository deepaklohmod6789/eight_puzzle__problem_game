import 'dart:math';
import 'package:flutter/material.dart';

class Tile{
  final int maxRows;
  const Tile(this.maxRows);

  bool isInFirstRow(int index){
    return index>=0&&index<maxRows;
  }

  bool isInLastRow(int index){
    int last=pow(maxRows,2).toInt()-1;
    return index>=last-maxRows&&index<=last;
  }

  bool isInFirstColumn(int index){
    return index%maxRows==0;
  }

  bool isInLastColumn(int index){
    return (index+1)%maxRows==0;
  }

  static bool isSwipedRight(DismissDirection direction){
    return direction == DismissDirection.startToEnd;
  }

  static bool isSwipedLeft(DismissDirection direction){
    return direction == DismissDirection.endToStart;
  }

  static bool isSwipedDown(DismissDirection direction){
    return direction == DismissDirection.down;
  }

  static bool isSwipedUp(DismissDirection direction){
    return direction == DismissDirection.up;
  }

}