import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:veloz/objects/metricsClass.dart';

class TestPage extends StatefulWidget{
  final String ipTest;

  const TestPage({Key key, @required this.ipTest}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  final Metrics _metric = Metrics();
  int pingAvg;

  void _pingTest(String ip) async{
    int ping = await _metric.pingTest(ip);
    setState(() {
      this.pingAvg = ping;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(pingAvg == null){
      _pingTest(widget.ipTest);
    }
    
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            
            Text(this.pingAvg.toString())
          ]
        ),
      ),
    );
  }

}