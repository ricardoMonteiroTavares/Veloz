import 'dart:async';

import 'package:Veloz/functions/avg.dart' as average;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Veloz/objects/database.dart';
import 'package:Veloz/objects/metricsClass.dart';
import 'package:Veloz/objects/resultClass.dart';

class TestPageController{
  final Metrics _metric = Metrics();
  final StreamController _streamController = new StreamController();
  ResultTest result = new ResultTest(
    date: DateFormat('yyyy-MM-dd-kk-mm').format(DateTime.now()),
    downAvg: null,
    latencyAvg: null,
    upAvg: null,
    );
  bool sucess = false;

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  bool opacity = true;

  void invertOpacity(){
    this.opacity = !this.opacity;
    _streamController.add(this.opacity);
  } 

  void latencyTest(String ip) async{
    int latency = await this._metric.latencyTest(ip);
    this.result.latencyAvg = latency;
    _streamController.add(this.result.latencyAvg);
  }


  // Esta função realiza o teste de download
  // Entrada: o endereço do site
  // Saída: a velocidade média em kbps de até 15 testes
  void downloadTest(String host)async{
    int down;
    List<double> results = new List<double>();
    for(int i = 0; i < 15; i++){
      down = await this._metric.downloadTest(host);
      if(down != -1 && down != null){
        results.add(down.toDouble());
      }
    }
    if(results.length != 0){
      this.result.downAvg = average.avg(results);
    }else{
      this.result.downAvg = -1;
    }
    _streamController.add(this.result.downAvg);
  }

  // Esta função realiza o teste de upload
  // Entrada: o endereço do site
  // Saída: a velocidade média em kbps de até 15 testes
  void uploadTest(String host)async{
    int up;
    List<double> results = new List<double>();
    for(int i = 0; i < 15; i++){
      up = await this._metric.uploadTest(host);
      if(up != -1 && up != null){
        results.add(up.toDouble());
      }
    }
    if(results.length != 0){
      this.result.upAvg = average.avg(results);
    }else{
      this.result.upAvg = -1;
    }
    
    _streamController.add(this.result.upAvg);
  }

  Future<bool> saveResult(int idServer) async{
    if((this.result.upAvg != null) && (this.result.downAvg != null) && (this.result.latencyAvg != null)){
      this.result.idServer = idServer;
      await DBProvider.db.insertResult(this.result);
      return true;
    }else{
      return false;
    }
  }

  // Função responsável pelo design tanto do servidor a ser testado, quanto para o ip do Smartphone 
  Widget connectInfo(String name, String dns, Color color){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 18,
              color: color,
            ),
          ),
          Text(
            dns,
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: color,
            ),
          ),
        ],
      );
  }

  // Função que mudará a cor enquato o resultado do teste atual for null
  Color setColor(int value, Color color){
      if(value == null){
        return (this.opacity)? color : Colors.transparent;
      }
      return color;
  }

  void dispose(){
    this._streamController.close();
  }    
}
