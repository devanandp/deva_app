import 'package:flutter/material.dart';

class Rainbow extends StatefulWidget {
  @override
  _RainbowState createState() => _RainbowState();
}

class _RainbowState extends State<Rainbow> {

  Color colval = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Rainbow App")),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                child: Image.asset('assets/images/flutter.png', width: 50, height: 60,),
                padding: EdgeInsets.all(50),
                color: colval,
                height: 300,
                width: 300,
              ),
            ),
            FlatButton(
              child: Text("Violet"),
              color: Colors.purple,
              onPressed: (){
                setState(() {
                  colval = Colors.purple;
                });
              },
            ),
            FlatButton(
              child: Text("Indigo"),
              color: Colors.indigo,
              onPressed: (){
                setState(() {
                  colval = Colors.indigo;
                });
              },
            ),
            FlatButton(
              child: Text("Blue"),
              color: Colors.blue,
              onPressed: (){
                setState(() {
                  colval = Colors.blue;
                });
              },
            ),
            FlatButton(
              child: Text("Green"),
              color: Colors.greenAccent,
              onPressed: (){
                setState(() {
                  colval = Colors.greenAccent;
                });
              },
            ),
            FlatButton(
              child: Text("Yellow"),
              color: Colors.yellow,
              onPressed: (){
                setState(() {
                  colval = Colors.yellow;
                });
              },
            ),
            FlatButton(
              child: Text("Orange"),
              color: Colors.orange,
              onPressed: (){
                setState(() {
                  colval = Colors.orange;
                });
              },
            ),
            FlatButton(
              child: Text("Red"),
              color: Colors.red,
              onPressed: (){
                setState(() {
                  colval = Colors.red;
                });
              },
            )
          ],
        ),
      ),

    );
  }
}
