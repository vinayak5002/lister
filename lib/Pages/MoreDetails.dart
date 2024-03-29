import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as API ;
import 'package:lister/Data/data.dart';
import 'package:provider/provider.dart';


import '../Data/constant.dart';
import '../Models/Show.dart';


class MoreDetails extends StatefulWidget {
  const MoreDetails({Key? key, required this.show, this.fromMain = false, }) : super(key: key);

  final Show show;
  
  // get fromMain => null;
  final bool fromMain;

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  bool isLoading = true;
  var data;
  late int eps;

  getDetails()async{
    setState(() {
      isLoading = true;
    });

    API.Response response = await API.get( Uri.parse(kMoreDetailsURL + widget.show.malId.toString()) );

    setState(() {
      isLoading = false;
    });

    setState(() {
      data = jsonDecode(response.body);
      data = data['data'];
      eps = data['episodes'];
    });
  }

  List<Widget> getBody(){
    if(data['type'] != 'Movie'){
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
          child: Image.network(widget.show.imageURL),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            textAlign: TextAlign.center,
            widget.show.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),
            maxLines: 10,
            overflow: TextOverflow.visible,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(data['episodes'] != null ? "Episodes: ${data['episodes']}" : "Episodes: N/A",  style: const TextStyle(fontSize: 20),),
              Text(data['status'].toString(),  style: const TextStyle(fontSize: 20),),
            ],
          ),
        ), 

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text("${data['season']} ${data['year']}",  style: const TextStyle(fontSize: 20),),
        ),

        data['airing'] == false ?
        Text("Aired from ${data['aired']['string']}", style: const TextStyle(fontSize: 20),) :
        Text("Airing on ${data['broadcast']['string']}", style: const TextStyle(fontSize: 20),),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
          child: Text("${data['synopsis']}", style: const TextStyle(fontSize: 15),),
        ),       
      ];
    }
    else{
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
          child: Image.network(widget.show.imageURL),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            textAlign: TextAlign.center,
            widget.show.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),
            maxLines: 10,
            overflow: TextOverflow.visible,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Movie",  style: TextStyle(fontSize: 20),),
              Text(data['duration'].toString(),  style: const TextStyle(fontSize: 20),),
            ],
          ),
        ), 

        const SizedBox(height: 10),

        Text("Released ${data['aired']['string']}", style: const TextStyle(fontSize: 20)),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
          child: Text("${data['synopsis']}", style: const TextStyle(fontSize: 15),),
        ),       
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),

        body: 
        isLoading ? const Center(
          child: SpinKitWave(
            color: Colors.redAccent,
            size: 50,
          ),
        ) :
        
        SingleChildScrollView(
          child: Column(
            children: getBody(),
          ),
        ),
        

        floatingActionButton:
        !widget.fromMain ?
         FloatingActionButton(
          onPressed: (){
            print("Before addShow: ${widget.show.airWeekDay}");
            Provider.of<Data>(context, listen: false).addShow(widget.show);
            Navigator.pop(context);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, color: Colors.white,),
        )
        :
        null,
      ),
    );
  }
}