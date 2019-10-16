import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Veloz/objects/database.dart';
import 'package:Veloz/objects/resultClass.dart';
import 'package:Veloz/objects/serverClass.dart';
import 'dart:math';

class HistoryPageController{

  List<Server> servers = Server.getServers();
  List<DropdownMenuItem<Server>> dropdownMenuItems;
  Server selectedServer;
  List<List<double>> chartData;


  final StreamController _streamController = new StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void buildServers(){
    List<DropdownMenuItem<Server>> itens = List();
    for (Server s in this.servers){
      itens.add(
        DropdownMenuItem(
          value: s, 
          child: ListTile(
            leading: SvgPicture.asset(s.icon, height: 20, width: 20,),
            title: Text(
              s.name,
              style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 20,
                  color: Color.fromARGB(255, 66, 115, 227)
              ),
              //textAlign: TextAlign.center,
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

    this.chartData = [[],[],[]];
    for(ResultTest i in data){
      this.chartData[0].insert(0,i.pingAvg.toDouble());
      this.chartData[1].insert(0,i.downAvg.toDouble());
      this.chartData[2].insert(0,i.upAvg.toDouble());
    }
    this._streamController.add(this.chartData);
  }

  int avg(List<double> data){
    return ((data.reduce((curr, next) => curr + next))/data.length).round();
  }

  int _standardDeviation(List<double> data){
    int avg = this.avg(data);
    int total = 0;
    for (double i in data){
      total += pow((i-avg),2).toInt();
    }

    return sqrt(total/data.length).round();

  }

  int minimal(List<double> data){
    int value = (this.avg(data) - this._standardDeviation(data));
    if (value < 0){
      return 0;
    }
    return value;
  }

  int maximal(List<double> data)
    => (this.avg(data) + this._standardDeviation(data));

  void dispose(){
    this._streamController.close();
  }
}