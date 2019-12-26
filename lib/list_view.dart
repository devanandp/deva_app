import 'package:flutter/material.dart';

class Listviewer extends StatefulWidget {
  @override
  _ListviewerState createState() => _ListviewerState();
}

class _ListviewerState extends State<Listviewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text("List View"),),
      body: Container(
        child: ListView(
  children: <Widget>[
    ListTile(
      title: Text("Hello"),
      trailing: FlatButton(child: Icon(Icons.delete, color: Colors.redAccent,),
      onPressed: (){

      },
      ),
    ),
    Container(
      child: Center(
        child: RaisedButton(
          child: Text("Add",),
          onPressed: (){

          },
          color: Colors.green,
        ),
      ),
    )
  ],
        )

        )
      );


  }
}
