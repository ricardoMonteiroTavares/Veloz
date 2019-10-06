import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veloz/objects/serverClass.dart';

class HomePageController{
  List<Server> servers = Server.getServers();
  List<DropdownMenuItem<Server>> dropdownMenuItems;
  Server selectedServer;
    
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
  }
}