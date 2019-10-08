import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veloz/HistoryPage/historyPageController.dart';
//import 'package:veloz/HomePage/homePage.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<HistoryPage> createState() => _HistoryPageState();

}

class _HistoryPageState extends State<HistoryPage>{
  HistoryPageController _controller = new HistoryPageController();

  void initState(){
    this._controller.buildServers();
    this._controller.onChangeItem(this._controller.dropdownMenuItems[0].value);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Histórico',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 30,
                    color: Color.fromARGB(255, 66, 115, 227),

                  ),
                ),
                Container(
                  child: DropdownButton(
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
                )
              ],
            ),
          )
        );
      } ,
    );
  }

}
