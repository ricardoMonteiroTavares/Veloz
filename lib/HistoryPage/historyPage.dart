import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veloz/HistoryPage/historyPageController.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
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

  Widget _titleTest(String icon, String type, Color color){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(icon, height: 40, width: 40,),
            SizedBox(
              width: 15,
            ),
            Text(
              type,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20,
                color: color,
              ),
            )
          ],
        );
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
                ),
                this._titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                Container(
                  height: 100,
                  child: Sparkline(
                    data: this._controller.chartData[0],
                    lineColor: Color.fromARGB(255, 255, 165, 0),
                    pointsMode: PointsMode.all,
                    pointColor: Color.fromARGB(255, 255, 165, 0),
                    fillMode: FillMode.below,
                    fillColor: Color.fromARGB(120, 255, 165, 0),
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
