import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lister/Models/StatusEnum.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Data/data.dart';
import '../Models/Show.dart';
import '../Pages/MoreDetails.dart';

class ShowTile extends StatefulWidget {
  ShowTile({Key? key, required this.show}) : super(key: key);

  final Show show;

  @override
  State<ShowTile> createState() => _ShowTileState();
}

class _ShowTileState extends State<ShowTile> {

  
  showModalSheet(StateSetter setState){

    List<ShowStatus> modalButtons;
    bool showProgress;

    if(widget.show.airStatus != AirStatus.shedueled && widget.show.status != ShowStatus.completed){
      switch (widget.show.status) {
        case ShowStatus.watching:
          modalButtons = [
            ShowStatus.onHold,
            ShowStatus.dropped,
          ];
          break;
        
        case ShowStatus.onHold:
          modalButtons = [
            ShowStatus.watching,
            ShowStatus.dropped,
          ];
          break;
        
        case ShowStatus.planned:
          modalButtons = [
            ShowStatus.watching,
            ShowStatus.onHold,
            ShowStatus.dropped,
          ];
          break;
        
        case ShowStatus.dropped:
          modalButtons = [
            ShowStatus.watching,
            ShowStatus.onHold,
            ShowStatus.planned,
          ];
          break;
        default:
          modalButtons = [];
      }
      showProgress = true;
    }
    else{
      modalButtons = [];
      showProgress = false;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text(
            widget.show.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: modalButtons.length,
            itemBuilder: (context, index) {
              return TextButton(
                child: Text("Change to ${Provider.of<Data>(context).displayStatus(modalButtons[index])[0]}"),
                onPressed: () {
                  setState(() {
                    Provider.of<Data>(context, listen: false).setStatus(widget.show, modalButtons[index]);
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.show.epsCompleted.toString()} / ${widget.show.epsTotal.toString()}", style: const TextStyle(fontSize: 20),),
          ],
        ),

        showProgress ?
        Expanded(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.red,),
                onPressed: (){
                  setState(() {
                    Provider.of<Data>(context, listen: false).decreaseEps(widget.show);
                  });
                },
              ),
              Expanded(
                child: StepProgressIndicator(
                  totalSteps: widget.show.epsTotal,
                  currentStep: widget.show.epsCompleted > widget.show.epsTotal ? widget.show.epsTotal : widget.show.epsCompleted,
                  size: 8,
                  padding: 0,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.cyan,
                  roundedEdges: const Radius.circular(10),
                  selectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.green],
                  ),
                  unselectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.grey],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.red,),
                onPressed: (){
                  setState(() {
                    Provider.of<Data>(context, listen: false).increaseEps(widget.show);
                  });
                },
              ),
            ],
          )
        ) : Container(),

        TextButton(
          child: const Text(
            "Delete show",
            style: TextStyle(
              color: Colors.red,
              fontSize: 15
            ),
          ),
          onPressed: (){
      
          },
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
      ],
    );
  
  }

  @override
  Widget build(BuildContext context) {
    late final status = Provider.of<Data>(context).displayStatus(widget.show.status);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),

      child: Card(
        color: const Color.fromRGBO(33, 33, 33, 1),
        
        child: Padding(
          padding: const EdgeInsets.all(4.0),

          child: Row(
            children: [
              InkWell(
                child: Image.network(widget.show.imageURL, height: 100, width: 100,),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => MoreDetails(show: widget.show, fromMain: true,))),
                  );
                },
              ),

              Expanded(
                child: SizedBox(
                  width: 10000,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.show.title.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                maxLines: 4,
                              ),
                            ),
              
                            InkWell(
                              child: const Icon(Icons.more_vert, color: Colors.redAccent,),
              
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (context){
                                  // return showModalSheet();
                                  return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState){
                                      return showModalSheet(setState);
                                    }
                                  );
                                });
                              },
                            )
                          ],
                        ),
              
                        const SizedBox(height: 5,),
              
                        Row(
                          children: [
                            status[1],
                            const SizedBox(width: 5,),
                            Expanded(child: Text(status[0])),
                            const SizedBox(width: 20,),
                            widget.show.airStatus == AirStatus.airing ? 
                            const Text("Airing")
                            :
                            widget.show.airStatus == AirStatus.finished ?
                            const Text("Finished airing")
                            :
                            const Text("Sheduled")
                          ],
                        ),
              
                        const SizedBox(height: 5,),
              
                        Text(
                          "${widget.show.epsCompleted}/${widget.show.epsTotal}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
              
                        Row(
                          children: [
                            Expanded(
                              child: StepProgressIndicator(
                                totalSteps: widget.show.epsTotal == 0 ? 1: widget.show.epsTotal,
                                currentStep: widget.show.epsCompleted > widget.show.epsTotal ? widget.show.epsTotal : widget.show.epsCompleted,
                                size: 8,
                                padding: 0,
                                selectedColor: Colors.yellow,
                                unselectedColor: Colors.cyan,
                                roundedEdges: const Radius.circular(10),
                                selectedGradientColor: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.blue, Colors.green],
                                ),
                                unselectedGradientColor: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.grey, Colors.grey],
                                ),
                              ),
                            ),
              
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: InkWell(
                                onTap: () {

                                  if((widget.show.airStatus == AirStatus.finished || widget.show.airStatus == AirStatus.airing) && widget.show.epsCompleted < widget.show.epsTotal){

                                    if(widget.show.status == ShowStatus.planned){
                                      setState(() {
                                        widget.show.status = ShowStatus.watching;
                                        Provider.of<Data>(context, listen: false).setStatus(widget.show, ShowStatus.watching);
                                      });
                                    }
                                    if(widget.show.status == ShowStatus.dropped){
                                      setState(() {
                                        widget.show.status = ShowStatus.watching;
                                        Provider.of<Data>(context, listen: false).setStatus(widget.show, ShowStatus.watching);
                                      });
                                    }
                                    if(widget.show.epsCompleted < widget.show.epsTotal) {
                                      Provider.of<Data>(context, listen: false).increaseEps(widget.show);
                                      setState(() {}); 
                                    }
                                  }
              
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.redAccent,
                                ),
                              ),
                            )
              
                          ],
                        ),
              
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        )
      )
    );
  }
}