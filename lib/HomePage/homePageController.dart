import 'dart:async';

import 'package:Veloz/functions/loadServers.dart' as load;
import 'package:flutter/material.dart';
import 'package:Veloz/objects/serverClass.dart';

class HomePageController{

  List<DropdownMenuItem<Server>> dropdownMenuItems;
  Server selectedServer;
    
  final StreamController _streamController = new StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void loadServers(){
    List<DropdownMenuItem<Server>> itens = load.loadServers();
    this.dropdownMenuItems = itens;
    this._streamController.add(this.dropdownMenuItems);
  }

  void onChangeItem(Server selected){
    selectedServer = selected;
    this._streamController.add(this.selectedServer);
  }

  void dispose(){
    this._streamController.close();
  }
}