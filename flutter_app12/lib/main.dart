import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String output ="0";
double num1 = 0.0;
double num2 =0.0;
String operand ="";
String _output="";

buttonPressed(String buttontext)
{
   if (buttontext=="CLEAR")
     {
        output ="0";
        num1 = 0.0;
       num2 =0.0;
       operand ="";
        _output="";
     }
   else if(buttontext=="-"||buttontext=="+"||buttontext=="/"||buttontext=="*")
  {
  num1 = double.parse(output);
  operand=buttontext;
  _output ="0";
  } else if (buttontext==".")
  {
  if(_output.contains("."))
    {
      print("decimal present");
      return;
    }
  else
    {
      _output= _output +buttontext;
    }
  }
   else if (buttontext=="=")
     {
       num2 = double.parse(output);
       if(operand =="+")
       {
         _output=(num1+num2).toString();
       }
       else if(operand =="-")
       {
         _output=(num1-num2).toString();
       }
       else if(operand =="/")
       {
         _output=(num1/num2).toString();
       }
       else if (operand =="*")
       {
         _output=(num1*num2).toString();
       }
       num1=0.0;
       num2=0.0;
      operand="";
     }
   else
     {
       _output= _output +buttontext;
     }
print(_output);
   setState(() {
      output= _output;
   });
}

 Widget buildbutton(String buttontext){
 return  new Expanded (
 child: new MaterialButton(
   padding: EdgeInsets.all(24.0),
 child: new Text(buttontext,
 style:TextStyle(
    fontSize: 20.0,
   fontWeight: FontWeight.bold
 )),
 onPressed: () =>{
     buttonPressed(buttontext)
 },
 color: Colors.deepPurple,
 textColor: Colors.white,
 ),
 );
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new Container(
        child:new Column(children: <Widget>[
          new Container(
              alignment:Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal:12.0
              ),
              child: new Text(output,
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold
          ),)),
          new Expanded(
            child: new Divider(),),


          Column(
            children: <Widget>[
              new Row(
              children:[
                buildbutton("1"),
                buildbutton("2"),
                buildbutton("3"),
                buildbutton("/")
  ]),
              new Row(
                  children:[
                    buildbutton("4"),
                    buildbutton("5"),
                    buildbutton("6"),
                    buildbutton("*")
                  ]),
              new Row(
                  children:[
                    buildbutton("7"),
                    buildbutton("8"),
                    buildbutton("9"),
                    buildbutton("+")
                  ]),
              new Row(
                  children:[
                    buildbutton("."),
                    buildbutton("0"),
                    buildbutton("00"),
                    buildbutton("-")
                  ]),
              new Row(
                  children:[
                    buildbutton("CLEAR"),
                    buildbutton("=")
                  ]),
            ],
          )
        ],),
      )
    );
  }
}
