import 'package:Veloz/objects/serverClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<DropdownMenuItem<Server>> loadServers() {
  List<Server> servers = Server.getServers();
  List<DropdownMenuItem<Server>> itens = List();
    for (Server s in servers){
      itens.add(
        DropdownMenuItem(
          value: s, 
          child: ListTile(
            leading: SvgPicture.asset(s.icon, height: 30, width: 30,),
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
  return itens;
}