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
  int airWeekDay;
  DateTime lastUpdated;

  Show({
    required this.malId,
    required this.title,
    required this.epsCompleted,
    required this.epsTotal,
    required this.status,
    required this.imageURL,
    required this.airStatus,
    required this.gogoName,
    required this.airWeekDay,
    required this.lastUpdated
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

    return Show(
      malId: jsonData['malId'],
      title: jsonData['title'],
      epsCompleted: jsonData['epsCompleted'],
      epsTotal: jsonData['epsTotal'],
      status: ShowStatus.values[jsonData['status']],
      imageURL: jsonData['imageURL'],
      airStatus: AirStatus.values[jsonData['airStatus']],
      gogoName: jsonData['gogoName'],
      airWeekDay: int.parse(jsonData['airingDay']),
      lastUpdated: DateTime.parse(jsonData['lastUpdated'])
    );
  }

  static Map<String, dynamic> toMap(Show show) {
    return {
      'malId': show.malId,
      'title': show.title,
      'epsCompleted': show.epsCompleted,
      'epsTotal': show.epsTotal,
      'status': show.status.index,
      'imageURL': show.imageURL,
      'airStatus': show.airStatus.index,
      'gogoName' : show.gogoName,
      'airingDay': show.airWeekDay.toString(),
      'lastUpdated' : show.lastUpdated.toString()
    };
  }
}