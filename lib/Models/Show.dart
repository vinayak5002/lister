import './StatusEnum.dart';

const String defaultImage = "Hello";

class Show{
  const Show({
    required String title,
    required int epsCompleted,
    required int epsTotal,
    required ShowStatus status,
    String imageURL = defaultImage
  });
  
  int get epsCompleted{
    return epsCompleted;
  }
  
  get epsTotal => null;

  get status => null;

  set epsCompleted(int value) {
    epsCompleted = value;
  }

  void incrementEps(){
    if(epsCompleted < epsTotal){
      epsCompleted++;
    }
  }
}