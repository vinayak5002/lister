import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Models/Show.dart';

class ShowTile extends StatelessWidget {
  const ShowTile({Key? key, required this.show}) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),

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
                        show.title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const Icon(Icons.more_vert, color: Colors.redAccent,)
                    ],
                  ),

                  const SizedBox(height: 5,),

                  Text(
                    "${show.epsCompleted}/${show.epsTotal}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: StepProgressIndicator(
                          // totalSteps: show.epsCompleted,
                          // currentStep: show.epsTotal,
                          totalSteps: show.epsTotal,
                          currentStep: show.epsCompleted,
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

                      const Padding(
                        padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                        child: Icon(Icons.add, color: Colors.redAccent,),
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