import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:veloz/objects/metricsClass.dart';

class TestPage extends StatefulWidget{
  final String ipTest;
  final String hostTest;

  const TestPage(
    {
      Key key, 
      @required this.ipTest,
      @required this.hostTest,
    }
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  final Metrics _metric = Metrics();
  int pingAvg;
  int downAvg;
  int upAvg;

  void _pingTest(String ip) async{
    int ping = await this._metric.pingTest(ip);
    setState(() {
      this.pingAvg = ping;
    });
  }

  void _downloadTest(String host)async{
    int down = await this._metric.downloadTest(host);
    setState(() {
      this.downAvg = down;
    });
  }
  void _uploadTest(String ip)async{
    int up = await this._metric.uploadTest(ip);
    setState(() {
      this.upAvg = up;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(pingAvg == null){
      this._pingTest(widget.ipTest);
    }
    if(downAvg == null){
      this._downloadTest(widget.hostTest);
    }
    if(upAvg == null){
      this._uploadTest(widget.ipTest);
    }
    
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            
            Text(this.pingAvg.toString()),
            Text(this.downAvg.toString()),
            Text(this.upAvg.toString())
          ]
        ),
      ),
    );
  }

}