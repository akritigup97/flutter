import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_tictac/dialog.dart';
import 'package:flutter_app_tictac/game_button.dart';

 class HomePage extends StatefulWidget {
   @override
   _HomePageState createState() => _HomePageState();
 }

 class _HomePageState extends State<HomePage> {
   List<GameButton> buttonsList;
   var player1;
   var player2;
   var activePlayer;
   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }
  List<GameButton> doInit()
  {
    player1 =new List();
    player2 =new List();
    activePlayer =1;

    var gameButtons= <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),

    ];

    return gameButtons;
  }
  void playGame(GameButton gb)
  {
setState(() {
  if(activePlayer==1)
    {
      gb.text ="X";
      gb.bg =Colors.red;
      activePlayer= 2;
      player1.add(gb.id);
    }
  else
    {
      gb.text ="O";
      gb.bg = Colors.black;
      activePlayer=1;
      player2.add(gb.id);
    }
  gb.enabled = false;
  int winner = checkwinner();
  if(winner ==-1)
    {
      if(buttonsList.every((p)=>p.text!=""))
        {
          showDialog(context: context,
              builder: (_)=> new CustomDialog("game tie","Press the reset button to start again",resetGame));
        }
      /*else
          {
            if(activePlayer==2)
             autoplay();
          }*/
    }
});
  }
  void autoplay()
  {
var emptycells =new List();
var list =new List.generate(9,(i)=>i+1);
for(var cell in list)
  {
    if(player1.contains(cell)||player2.contains(cell))
      {
        emptycells.add(cell);
      }
  }
var r =new Random();
var randindex = r.nextInt(emptycells.length);
var cell = emptycells[randindex];
int i =buttonsList.indexWhere((p)=>p.id==cell);
playGame(buttonsList[i]);
  }



   int checkwinner()
  {
    var winner=-1;
    //row
    if(player1.contains(1)&&player1.contains(2)&&player1.contains(3))
  winner=1;
    if(player2.contains(1)&&player2.contains(2)&&player2.contains(3))
      winner=2;
    if(player1.contains(3)&&player1.contains(4)&&player1.contains(5))
      winner=1;
    if(player2.contains(3)&&player2.contains(4)&&player2.contains(5))
      winner=2;
    if(player1.contains(7)&&player1.contains(8)&&player1.contains(9))
      winner=1;
    if(player2.contains(7)&&player2.contains(8)&&player2.contains(9))
      winner=2;
    //column
    if(player1.contains(1)&&player1.contains(4)&&player1.contains(7))
      winner=1;
    if(player1.contains(2)&&player1.contains(5)&&player1.contains(8))
      winner=1;
    if(player1.contains(3)&&player1.contains(6)&&player1.contains(9))
      winner=1;
    //column
    if(player2.contains(1)&&player2.contains(4)&&player2.contains(7))
      winner=2;
    if(player2.contains(2)&&player2.contains(5)&&player2.contains(8))
      winner=2;
    if(player2.contains(3)&&player2.contains(6)&&player2.contains(9))
      winner=2;
    //diagonal
     if(player1.contains(1)&&player1.contains(5)&&player1.contains(9))
    winner=1;
    if(player1.contains(3)&&player1.contains(5)&&player1.contains(7))
      winner=1;

    if(player2.contains(1)&&player2.contains(5)&&player2.contains(9))
      winner=2;
    if(player2.contains(3)&&player2.contains(5)&&player2.contains(7))
      winner=2;
    if(winner!=-1)
      {
        if(winner==1)
          {
            showDialog(context: context,
            builder: (_)=> new CustomDialog("player1 won","Press the reset button to start again",resetGame));




          }else
            {
              showDialog(context: context,
                  builder: (_)=> new CustomDialog("player2 won","Press the reset button to start again",resetGame));



            }

            }

print(winner);
return winner;

  }
   void resetGame()
   {
     if(Navigator.canPop(context))Navigator.pop(context);
  setState(() {
    buttonsList=doInit();
  });

   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar:  new AppBar(
         title: new Text("  Tic tac toe" ),
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           new Expanded(
             child: new GridView.builder(itemCount: buttonsList.length,
             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 3,
             childAspectRatio: 1.0,
             crossAxisSpacing: 9.0,
             mainAxisSpacing: 9.0),
             itemBuilder: (context,i)=>new SizedBox(
               width: 100,
               height: 100,
               child: new RaisedButton(
                 padding: const EdgeInsets.all(8.0),
                 onPressed: buttonsList[i].enabled?()=>playGame(buttonsList[i]):null,
                 child: new Text(buttonsList[i].text,
                 style: new TextStyle(color: Colors.white,fontSize: 20.0),),
                 color: buttonsList[i].bg,
                 disabledColor: buttonsList[i].bg ,
               ),
             ),),
           ),
           new RaisedButton(
               child:new Text("Reset",style: new TextStyle(color: Colors.white,fontSize: 20.0),),
             color: Colors.red,
             padding: const   EdgeInsets.all(20.0),
             onPressed: resetGame,
           )
         ],
       ),
     );
   }
 }
