import 'package:eight_puzzle_game/classes/board.dart';
import 'package:eight_puzzle_game/classes/direction.dart';
import 'package:eight_puzzle_game/classes/tile.dart';
import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  static const int maxRows=3;
  List<int> currentState=[1,2,3,4,5,6,7,8,0];
  final Direction direction=Direction(maxRows);

  @override
  void initState() {
    startNewGame();
    super.initState();
  }

  void startNewGame(){
    currentState.shuffle();
    setState(() {
      checkGameSolvability();
    });
  }

  void checkGameSolvability()
  {
    bool gameCantBeSolved=Board.haveOddInverts(currentState);
    if (gameCantBeSolved)
    {
      currentState.shuffle();
      checkGameSolvability();
    }
  }

  void onHorizontalDismiss(DismissDirection direction,int index){
    if (Tile.isSwipedRight(direction)) {
      setState(() {
        int temp=currentState[index+1];
        currentState[index+1]=0;
        currentState[index]=temp;
      });
    }
    else if (Tile.isSwipedLeft(direction)) {
      setState(() {
        int temp=currentState[index-1];
        currentState[index-1]=0;
        currentState[index]=temp;
      });
    }
    checkPuzzleIsSolved();
  }

  void onVerticalDismiss(DismissDirection direction,int index){
    if (Tile.isSwipedUp(direction)) {
      setState(() {
        int temp=currentState[index-maxRows];
        currentState[index-maxRows]=0;
        currentState[index]=temp;
      });
    }
    else if (Tile.isSwipedDown(direction)) {
      setState(() {
        int temp=currentState[index+maxRows];
        currentState[index+maxRows]=0;
        currentState[index]=temp;
      });
    }
    checkPuzzleIsSolved();
  }

  void checkPuzzleIsSolved()
  {
    if(Board.haveSameGoalStateAndCurrentState(currentState))
    {
      puzzleSolvedDialog(context);
    }
  }

  void puzzleSolvedDialog(BuildContext context){
    var alertDialog=Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45,width: 5),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Congratulations!!',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('You win!! The puzzle is solved.',style: TextStyle(fontSize: 17.0,),),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.blue,
                child: Text("Play Again",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                onPressed: (){
                  startNewGame();
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width/1.5,
                left: MediaQuery.of(context).size.width/8,
                right: MediaQuery.of(context).size.width/8,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.white,width: 5)
              ),
              child: GridView.count(
                crossAxisCount: maxRows,
                shrinkWrap: true,
                children: List.generate(currentState.length, (index) {
                  return currentState[index]==0?Dismissible(
                    key: UniqueKey(),
                    direction: direction.forHorizontalDismiss(index),
                    onDismissed: (direction) {
                     onHorizontalDismiss(direction,index);
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: direction.forVerticalDismiss(index),
                      onDismissed: (direction) {
                        onVerticalDismiss(direction, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(child: Text(currentState[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500),)),
                      ),
                    ),
                  ):Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(child: Text(currentState[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500),)),
                  );
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width/2.5,
                left: MediaQuery.of(context).size.width/4,
              ),
              child: Text(
                "8 Puzzle game",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.93,),
              child: Text(' - @deepaklohmod6789',),
            ),
          ],
        ),
      ),
    );
  }
}