import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lister/Models/StatusEnum.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Data/data.dart';
import '../Models/Show.dart';

class ShowTile extends StatefulWidget {
  ShowTile({Key? key, required this.show}) : super(key: key);

  final Show show;

  @override
  State<ShowTile> createState() => _ShowTileState();
}

class _ShowTileState extends State<ShowTile> {

  @override
  Widget build(BuildContext context) {
    late final status = displayStatus(widget.show.status);

    showModalSheet(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.show.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          TextButton(
            onPressed: (){
              setState(() {
                setStatus(widget.show, ShowStatus.onHold);
              });
              Navigator.of(context).pop();
            },
            child: Text("Move to onHold", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),

      child: Card(
        color: const Color.fromRGBO(33, 33, 33, 1),
        
        child: Padding(
          padding: const EdgeInsets.all(4.0),

          child: Container(
            width: 10000,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.show.title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),

                      InkWell(
                        child: Icon(Icons.more_vert, color: Colors.redAccent,),

                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context){
                            return showModalSheet();
                          });
                        },
                      )
                    ],
                  ),

                  const SizedBox(height: 5,),

                  Text(
                    "${widget.show.epsCompleted}/${widget.show.epsTotal}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: 5,),

                  Row(
                    children: [
                      status[1],
                      const SizedBox(width: 5,),
                      Text(status[0]),
                    ],
                  ),

                  Row(
                    children: [
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

                      Padding(
                        padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                        child: InkWell(
                          onTap: () {
                            if(widget.show.status == ShowStatus.planned){
                              setState(() {
                                widget.show.status = ShowStatus.watching;
                              });
                            }
                            if(widget.show.epsCompleted < widget.show.epsTotal) {
                              increaseEps(widget.show);
                              setState(() {}); 
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

        )
      )
    );
  }
}