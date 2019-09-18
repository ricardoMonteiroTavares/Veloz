import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Veloz',
            style: TextStyle(fontFamily: 'Poiret One', fontSize: 90, color: Color.fromARGB(255, 66, 115, 227)),
          ),

          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            color: Color.fromARGB(255, 66, 115, 227),
            child: Text('Começar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){},
          ),

          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Color.fromARGB(255, 66, 115, 227),width: 1)
            ),
            child: Text('Histórico',
              style: TextStyle(color: Color.fromARGB(255, 66, 115, 227)),
            ),
            onPressed: (){},
          ),
        ],
      ),
    );
  }

}