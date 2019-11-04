/*
 *  Página Inicial 
 */

import 'package:flutter/material.dart';
import 'package:Veloz/HistoryPage/historyPage.dart';
import 'package:Veloz/HomePage/homePageController.dart';
import 'package:Veloz/TestPage/testPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get_ip/get_ip.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  HomePageController _controller = new HomePageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState(){
    this._controller.loadServers();
    this._controller.onChangeItem(this._controller.dropdownMenuItems[0].value);
    super.initState();
  }

  void _errorMessage(){
    final snackBar = SnackBar(
      content: Text(
        "É necessário estar conectado à Internet",
        style: TextStyle(color: Colors.white),
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
    );

    this._scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Título do App
                Text('Veloz',
                  style: TextStyle(
                      fontFamily: 'Poiret One',
                      fontSize: 90,
                      color: Color.fromARGB(255, 66, 115, 227)
                  ),
                  textAlign: TextAlign.center,
                ),

                // Região onde o usuário escolhe o servidor
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (' '*7)+'Escolha o servidor para teste:',
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: Color.fromARGB(255, 66, 115, 227)
                        ),
                        textAlign: TextAlign.start,
                      ),
                      DropdownButton(
                        value: this._controller.selectedServer,
                        items: this._controller.dropdownMenuItems,
                        onChanged: this._controller.onChangeItem,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Color.fromARGB(255, 66, 115, 227),
                        iconSize: 30,
                        underline: SizedBox(),
                        
                      ),

                    ],
                  ),
                ),

                // Bloco de código onde escolhe se vai realizar o teste ou acessar o histórcio
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
                              onPressed: () async{

                                var connectivity = await Connectivity().checkConnectivity();
                                if((connectivity == ConnectivityResult.wifi) || (connectivity == ConnectivityResult.mobile)){
                                      String getIP = await GetIp.ipAddress;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => TestPage(serverTest: this._controller.selectedServer, ipLocal: getIP)
                                          )
                                      );
                                }else{
                                   WidgetsBinding.instance.addPostFrameCallback((_) => this._errorMessage());  
                                }
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
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HistoryPage()
                                  )
                                );
                              },
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
      },
    );
    
     
  }

  @override
  void dispose(){
    this._controller.dispose();
    super.dispose();
  }

}


