import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veloz/objects/database.dart';
import 'package:veloz/objects/resultClass.dart';
import 'package:veloz/objects/serverClass.dart';
import 'dart:math';

class HistoryPageController{

  List<Server> servers = Server.getServers();
  List<DropdownMenuItem<Server>> dropdownMenuItems;
  Server selectedServer;
  List<List<double>> chartData;
 // List<double> ping;
 // List<double> down;
//  List<double> up;

  final StreamController _streamController = new StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

void buildServers(){
    List<DropdownMenuItem<Server>> itens = List();
    for (Server s in this.servers){
      itens.add(
        DropdownMenuItem(
          value: s, 
          child: Text(
            s.name,
            style: TextStyle(
              fontFamily: 'Open Sans', 
              fontSize: 20, 
              color: Color.fromARGB(255, 66, 115, 227) 
            ),
          )
        )
      );
    }
    this.dropdownMenuItems = itens;
    this._streamController.add(this.dropdownMenuItems);
  }

  void onChangeItem(Server selected){
    selectedServer = selected;
    this._streamController.add(this.selectedServer);
    print(this.selectedServer.name);
    this.onChangeData();
  }

  void onChangeData()async{
    List<ResultTest> data = await DBProvider.db.getClient(this.selectedServer.id);
    //this._streamController.add(this.data);
    this.chartData = [[],[],[]];
    for(ResultTest i in data){
      this.chartData[0].add(i.pingAvg.toDouble());
      this.chartData[1].add(i.downAvg.toDouble());
      this.chartData[2].add(i.upAvg.toDouble());
    }
    this._streamController.add(this.chartData);
  }

  int avg(List<double> data){
    return ((data.reduce((curr, next) => curr + next))/data.length).round();
  }

  int standardDeviation(List<double> data){
    int avg = this.avg(data);
    int total = 0;
    for (double i in data){
      total += pow((i-avg),2).toInt();
    }

    return sqrt(total/data.length).round();

  }
}