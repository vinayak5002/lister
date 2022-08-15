import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as API ;
import 'package:lister/Data/data.dart';
import 'package:provider/provider.dart';


import '../Data/constanst.dart';
import '../Models/Show.dart';


class MoreDetails extends StatefulWidget {
  const MoreDetails({Key? key, required this.show}) : super(key: key);

  final Show show;

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
    print("getDetails called");
    setState(() {
      isLoading = true;
    });

    API.Response response = await API.get( Uri.parse(kMoreDetailsURL + widget.show.malId.toString()) );

    setState(() {
      isLoading = false;
      print("Loaded");
    });

    setState(() {
      data = jsonDecode(response.body);
      data = data['data'];
      eps = data['episodes'];
      print(eps);
    });
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
            icon: Icon(Icons.arrow_back, color: Colors.redAccent),
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
            children: [
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
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Provider.of<Data>(context, listen: false).addShow(widget.show);
            Navigator.pop(context);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}