import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// We have two players that we will name by playerA and playerB
  int set = 1; // For storing the current set
  // For the player A:
  int jeu1A = 0, jeu2A = 0;
  String scoreA = "0";
  // For the playerB
  int jeu1B = 0, jeu2B = 0;
  String scoreB = "0";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Polytech Open", textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Table(
            border:TableBorder.all(width: 2.0,color: Colors.cyan),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
                TableRow(
                  children: [
                    Text("Joueur A"),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: set == 1 ? 6 : 0)
                      ),
                        child: Text(jeu1A.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: set == 2 ? 6 : 0)
                        ),
                        child: Text(jeu2A.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
                  ]
                ),
                TableRow(
                    children: [
                      Text("Joueur B"),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: set == 1 ? 6 : 0)
                          ),
                          child: Text(jeu1B.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: set == 2 ? 6 : 0)
                          ),
                          child: Text(jeu2B.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
                    ]
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    width: 150,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.cyan
                    ),
                    child: Text("Joueur A", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  SwipeDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      height: 300,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text(
                        scoreA,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    onSwipeUp: () {
                        print("Printing swiping up ############");
                        switch(scoreA) {
                          case "0":
                            scoreA = "15";
                            break;
                          case "15":
                            scoreA = "30";
                            break;
                          case "30":
                            scoreA = "40";
                            break;
                          case "40":
                            if (scoreB == "40") scoreA = "ADV";
                            else if(scoreB == "ADV"){
                              scoreB = "40";
                            }else{
                              scoreA = "0";
                              scoreB = "0";
                              if(set == 1 && jeu1A < 6) jeu1A ++;
                              if(set == 2 && jeu2A < 6) jeu2A ++;
                              if(set == 1 && jeu1A == 6) set = 2; // After we will add a dialog for the tie-break or the end of the set
                            }
                            break;
                          case "ADV":
                            scoreA = "0";
                            scoreB = "0";
                            if(set == 1 && jeu1A < 6) jeu1A ++;
                            if(set == 2 && jeu2A < 6) jeu2A ++;
                            if(set == 1 && jeu1A == 6) set = 2;
                            break;
                        }
                        setState(() {
                        });
                    },
                    onSwipeDown: () {
                      print("Printing swiping down ############");
                      switch(scoreA) {
                        case "15":
                          scoreA = "0";
                          break;
                        case "30":
                          scoreA = "15";
                          break;
                        case "40":
                          scoreA = "30";
                          break;
                        case "ADV":
                          scoreA = "40";
                          break;
                      }
                      setState(() {
                      });
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 150,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.cyan
                    ),
                    child: Text("Joueur B", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  SwipeDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      height: 300,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text(
                        scoreB,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    onSwipeUp: () {
                      switch(scoreB) {
                        case "0":
                          scoreB = "15";
                          break;
                        case "15":
                          scoreB = "30";
                          break;
                        case "30":
                          scoreB = "40";
                          break;
                        case "40":
                          if (scoreA == "40") scoreB = "ADV";
                          else if(scoreA == "ADV"){
                            scoreA = "40";
                          }else{
                            scoreA = "0";
                            scoreB = "0";
                            if(set == 1 && jeu1B < 6) jeu1B ++;
                            if(set == 2 && jeu2B < 6) jeu2B ++;
                            if(set == 1 && jeu1B == 6) set = 2; // After we will add a dialog for the tie-break or the end of the set
                          }
                          break;
                        case "ADV":
                          scoreA = "0";
                          scoreB = "0";
                          if(set == 1 && jeu1A < 6) jeu1B ++;
                          if(set == 2 && jeu2A < 6) jeu2B ++;
                          if(set == 1 && jeu1A == 6) set = 2;
                          break;
                      }
                      setState(() {
                      });
                    },
                    onSwipeDown: () {
                      print("Printing swiping down ############");
                      switch(scoreB) {
                        case "15":
                          scoreB = "0";
                          break;
                        case "30":
                          scoreB = "15";
                          break;
                        case "40":
                          scoreB = "30";
                          break;
                        case "ADV":
                          scoreB = "40";
                          break;
                      }
                      setState(() {
                      });
                    },
                  )
                ],
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Reset",
        child: Icon(Icons.clear),
        onPressed: (){
          set = 1;
          jeu1A = 0;
          jeu2A = 0;
          scoreA = "0";
          jeu1B = 0;
          jeu2B = 0;
          scoreB = "0";
          setState(() {
          });
        },
      ),
    );
  }
}
