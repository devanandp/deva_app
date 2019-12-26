import 'package:flutter/material.dart';
bool isSwitched = true;
var colortook;

class ColorApp extends StatefulWidget {
  ColorApp({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ColorAppState createState() {
    return _ColorAppState();
  }
}

class _ColorAppState extends State<ColorApp> {
  @override
  Widget build(BuildContext context) {
    chooseColor() {
      if (isSwitched) {
        return Colors.amber;
      } else {
        return Colors.lightBlue;
      }
    }

    textchanger() {
      if (isSwitched) {
        return Text("Change to Night mode");
      } else {
        return Text("Change to Day mode");
      }
    }



    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: textchanger(),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: colortook,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          colortook = chooseColor();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Buildbody(),
              )
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Buildbody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isSwitched) {
      return Container(
          color: Colors.amber,
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/sun.jpg"),
              Text(
                "Good Morning",
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          ));
    } else {
      return Container(
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/moon.jpg"),
              Text("Good Night",
                  style: TextStyle(color: Colors.pink, fontSize: 25)),
            ],
          ));
    }
  }
}