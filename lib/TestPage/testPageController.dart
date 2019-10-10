import 'dart:async';

import 'package:intl/intl.dart';
import 'package:veloz/objects/database.dart';
import 'package:veloz/objects/metricsClass.dart';
import 'package:veloz/objects/resultClass.dart';

class TestPageController{
  final Metrics _metric = Metrics();
  final StreamController _streamController = new StreamController();
  ResultTest result = new ResultTest(
    date: DateFormat('yyyy-MM-dd-kk-mm').format(DateTime.now()),
    downAvg: null,
    pingAvg: null,
    upAvg: null,
    );
  bool sucess = false;
  

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void pingTest(String ip) async{
    int ping = await this._metric.pingTest(ip);
    this.result.pingAvg = ping;
    _streamController.add(this.result.pingAvg);
  }

  void downloadTest(String host)async{
    int down = await this._metric.downloadTest(host);
    this.result.downAvg = down;
    _streamController.add(this.result.downAvg);
  }
  void uploadTest(String host)async{
    int up = await this._metric.uploadTest(host);
    this.result.upAvg = up;
    _streamController.add(this.result.upAvg);
  }

  Future<bool> saveResult(int idServer) async{
    if((this.result.upAvg != null) && (this.result.downAvg != null) && (this.result.pingAvg != null)){
      this.result.idServer = idServer;
      await DBProvider.db.insertResult(this.result);
      return true;
    }else{
      return false;
    }
  }

  void dispose(){
    this._streamController.close();
  }    
}
