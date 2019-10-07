import 'package:flutter/material.dart';
import 'package:veloz/HomePage/homePageController.dart';
import 'package:veloz/TestPage/testPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  HomePageController _controller = new HomePageController();


  void initState(){
    this._controller.buildServers();
    this._controller.onChangeItem(this._controller.dropdownMenuItems[0].value);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    // TODO: implement build

    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
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
                        value: this._controller.selectedServer,
                        items: this._controller.dropdownMenuItems,
                        onChanged: this._controller.onChangeItem,
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
                                    builder: (context) => TestPage(serverTest: this._controller.selectedServer, ipLocal: null,)
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
      },
    );
    
     
  }

  @override
  void dispose(){
    this._controller.dispose();
    super.dispose();
  }

}


