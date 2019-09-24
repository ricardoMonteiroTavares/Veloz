import 'package:flutter/material.dart';
import 'package:veloz/objects/serverClass.dart';
import 'package:veloz/TestPage/testPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  List<Server> _servers = Server.getServers();
  List<DropdownMenuItem<Server>> _dropdownMenuItems;
  Server _selectedServer;
    

  List<DropdownMenuItem<Server>> buildServers(List servers){
    List<DropdownMenuItem<Server>> itens = List();
    for (Server s in servers){
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
    return itens;
  }

  void onChangeItem(Server selected){
    setState(() {
      _selectedServer = selected;
    });
  }

  void initState(){
    _dropdownMenuItems = buildServers(_servers);
    _selectedServer = _dropdownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    // TODO: implement build

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Veloz',
              style: TextStyle(
                  fontFamily: 'Poiret One',
                  fontSize: 90,
                  color: Color.fromARGB(255, 66, 115, 227)
              ),
              textAlign: TextAlign.center,
            ),

            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Escolha o servidor para teste:',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 12,
                        color: Color.fromARGB(255, 66, 115, 227)
                    ),
                    textAlign: TextAlign.start,
                  ),
                  DropdownButton(
                    value: _selectedServer,
                    items: _dropdownMenuItems,
                    onChanged: onChangeItem,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: Color.fromARGB(255, 66, 115, 227),
                    iconSize: 30,
                    underline: Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 1,
                      color: Color.fromARGB(255, 66, 115, 227),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          color: Color.fromARGB(255, 66, 115, 227),
                          child: Text('Começar',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Open Sans',
                                fontSize: 20
                            ),
                          ),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TestPage(ipTest: _selectedServer.dns, hostTest: _selectedServer.host,)
                              )
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Color.fromARGB(255, 66, 115, 227),width: 1)
                          ),
                          child: Text('Histórico',
                            style: TextStyle(
                                color: Color.fromARGB(255, 66, 115, 227),
                                fontFamily: 'Open Sans',
                                fontSize: 20
                            ),
                          ),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          onPressed: (){},
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

}


