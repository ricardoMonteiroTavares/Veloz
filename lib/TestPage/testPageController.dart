import 'dart:async';

import 'package:veloz/objects/metricsClass.dart';

class TestPageController{
  final Metrics _metric = Metrics();
  final StreamController _streamController = new StreamController();
  int pingAvg;
  int downAvg;
  int upAvg;

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void pingTest(String ip) async{
    int ping = await this._metric.pingTest(ip);
    this.pingAvg = ping;
    _streamController.add(this.pingAvg);
  }

  void downloadTest(String host)async{
    int down = await this._metric.downloadTest(host);
    this.downAvg = down;
    _streamController.add(this.downAvg);
  }
  void uploadTest(String host)async{
    int up = await this._metric.uploadTest(host);
    this.upAvg = up;
    _streamController.add(this.upAvg);
  }    
}