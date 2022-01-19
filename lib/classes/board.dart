class Board{
  static const List<int> goalState=[1,2,3,4,5,6,7,8,0];

  static bool haveOddInverts(List<int> currentState){
    return _getCountOfInverts(currentState) % 2 != 0;
  }

  static int _getCountOfInverts(List<int> currentState) {
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

  static bool haveSameGoalStateAndCurrentState(List<int> currentState)
  {
    for(int i=0;i<currentState.length;i++) {
      if(currentState[i]!=goalState[i]) {
        return false;
      }
    }
    return true;
  }

}