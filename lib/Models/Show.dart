import './StatusEnum.dart';

const String defaultImage = "Hello";

class Show{
  int epsCompleted;
  String title;
  int epsTotal;
  ShowStatus status;
  String imageURL;

  Show({
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    required this.status,
    this.imageURL = defaultImage
  });

  int getEpsCompleted(){
    return epsCompleted;
  }

  void incrementEps(){
    if(epsCompleted < epsTotal){
      epsCompleted++;
    }
  }
}