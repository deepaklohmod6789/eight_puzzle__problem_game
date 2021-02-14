import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<int> currentState=[1,2,3,4,5,6,7,8,0];
  List<int> goalState=[1,2,3,4,5,6,7,8,0];
  bool isSolved=false;
  @override
  void initState() {
    currentState.shuffle();
    canBeSolved(); //to check whether list generated after shuffle can be solved or not
    super.initState();
  }

  int getCountOfInverts() {
    int countOfInverts = 0;
    for (int i = 0; i < currentState.length-1; i++) {
      for (int j = i + 1; j < currentState.length; j++) {
        if (currentState[i] > currentState[j])
          countOfInverts++;
      }
      if(currentState[i] == 0 && i % 2 == 1)
        countOfInverts++;
    }
    return countOfInverts;
  }

  void canBeSolved()
  {
    if (getCountOfInverts() % 2 != 0) //if it is odd then puzzle can't be solved so shuffle the pairs
    {
      setState(() {
        currentState.shuffle();
        canBeSolved(); // again call it to check the shuffled list generated
      });
    }
  }

  bool areGoalStateAndCurrentStateSame()
  {
    for(int i=0;i<currentState.length;i++) {
      if(currentState[i]!=goalState[i]) {
        return false;
      }
    }
    return true;
  }

  void checkIsSolved()
  {
    if(areGoalStateAndCurrentStateSame())
      {
        dialog(context);
      }
  }

  void dialog(BuildContext context){
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
                  setState(() {
                    currentState.shuffle();
                    canBeSolved();
                  });
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
                crossAxisCount: 3,
                shrinkWrap: true,
                children: List.generate(currentState.length, (index) {
                  DismissDirection dismissDirection1=DismissDirection.vertical;
                  DismissDirection dismissDirection2=DismissDirection.horizontal;
                  if(index==0||index==1||index==2)
                    {
                      dismissDirection1=DismissDirection.down; //in top row you can't move up
                    }
                  if(index==6||index==7||index==8)
                    {
                      dismissDirection1=DismissDirection.up;  //in bottom row you can't move down
                    }
                  if(index==0||index==3||index==6)
                    {
                      dismissDirection2=DismissDirection.startToEnd;  //in first column you can't move left
                    }
                  if(index==2||index==5||index==8)
                  {
                    dismissDirection2=DismissDirection.endToStart;  //in last column you can't move right
                  }
                  return currentState[index]==0?Dismissible(
                    key: UniqueKey(),
                    direction: dismissDirection2,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        print('swiped right');
                        setState(() {
                          int temp=currentState[index+1];
                          currentState[index+1]=0;
                          currentState[index]=temp;
                        });
                      }
                      else if (direction == DismissDirection.endToStart) {
                        print('swiped left');
                        setState(() {
                          int temp=currentState[index-1];
                          currentState[index-1]=0;
                          currentState[index]=temp;
                        });
                      }
                      setState(() {

                      });
                      checkIsSolved();
                      return Future.value(false); //
                      // always deny the actual dismiss, else it will expect the widget to be removed
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: dismissDirection1,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.up) {
                          print('swiped up');
                          setState(() {
                            int temp=currentState[index-3];
                            currentState[index-3]=0;
                            currentState[index]=temp;
                          });
                        }
                        else if (direction == DismissDirection.down) {
                          print('swiped down');
                          setState(() {
                            int temp=currentState[index+3];
                            currentState[index+3]=0;
                            currentState[index]=temp;
                          });
                        }
                        setState(() {

                        });
                        checkIsSolved();
                        return Future.value(false); //
                        // always deny the actual dismiss, else it will expect the widget to be removed
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                        ),
                        child: Center(child: Text(currentState[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w500),)),
                      ),
                    ),
                  ):Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
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