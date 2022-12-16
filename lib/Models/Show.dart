import './StatusEnum.dart';

class Show{
  int malId;
  int epsCompleted;
  String title;
  int epsTotal;
  ShowStatus status;
  String imageURL;
  AirStatus airStatus;
  String gogoName;
  DateTime airingDay = DateTime.now();

  Show({
    required this.malId,
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    required this.status,
    required this.imageURL,
    required this.airStatus,
    required this.gogoName,
    required this.airingDay
  });

  int getEpsCompleted(){
    return epsCompleted;
  }

  void incrementEps(){
    if(epsCompleted < epsTotal){
      epsCompleted++;
    }
  }

  static fromMap(Map<String, dynamic> jsonData) {    
    DateTime airingday;
    if(!jsonData.containsKey("lastUpdated")){
      airingday = DateTime(2003);
    }
    else{
      airingday = DateTime.parse(jsonData['lastUpdated']);
    }

    return Show(
      malId: jsonData['malId'],
      title: jsonData['title'],
      epsCompleted: jsonData['epsCompleted'],
      epsTotal: jsonData['epsTotal'],
      status: ShowStatus.values[jsonData['status']],
      imageURL: jsonData['imageURL'],
      airStatus: AirStatus.values[jsonData['airStatus']],
      gogoName: jsonData['gogoName'],
      airingDay: airingday
    );
  }

  static Map<String, dynamic> toMap(Show show) {
    if(show.airingDay == Null){
      show.airingDay = DateTime.now().weekday as DateTime;
    }
    return {
      'malId': show.malId,
      'title': show.title,
      'epsCompleted': show.epsCompleted,
      'epsTotal': show.epsTotal,
      'status': show.status.index,
      'imageURL': show.imageURL,
      'airStatus': show.airStatus.index,
      'gogoName' : show.gogoName,
      'airingDay': show.airingDay.toString()
    };
  }
}