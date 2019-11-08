import 'package:Veloz/functions/resultTest.dart' as result;
import 'package:Veloz/functions/titleTest.dart' as title;
import 'package:Veloz/functions/avg.dart' as average;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Veloz/HistoryPage/historyPageController.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

//import 'package:veloz/HomePage/homePage.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<HistoryPage> createState() => _HistoryPageState();

}

class _HistoryPageState extends State<HistoryPage>{
  HistoryPageController _controller = new HistoryPageController();

  @override
  void initState(){
    this._controller.loadServers();
    this._controller.onChangeItem(this._controller.dropdownMenuItems[0].value);
    
    super.initState();
  }

  Widget _lineResults(Color color, List<double> data, bool type){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("MÍN",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: color,
                  )
              ),
              result.resultTest(
                  this._controller.minimal(data),
                  color,
                  type, false
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text("MÉD",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: color,
                  )
              ),
              result.resultTest(
                  average.avg(data),
                  color,
                  type, false
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text("MÁX",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 15,
                    color: color,
                  )
              ),
              result.resultTest(
                  this._controller.maximal(data),
                  color,
                  type, false
              ),
            ],
          ),
        ]
    );
  }

  bool _dataExists(List<List<double>> data)
    => ((data[0].length >= 2) && (data[1].length >= 2) && (data[2].length >= 2));

  @override
  Widget build(BuildContext context) {    
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        if(this._controller.chartData == null){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Histórico'),
            iconTheme: IconThemeData(
              color: Color.fromARGB(255, 66, 115, 227),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            textTheme: TextTheme(
              title: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 30,
                color: Color.fromARGB(255, 66, 115, 227),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[

                  Container(
                    child: DropdownButton(
                      value: this._controller.selectedServer,
                      items: this._controller.dropdownMenuItems,
                      onChanged: this._controller.onChangeItem,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconEnabledColor: Color.fromARGB(255, 66, 115, 227),
                      iconSize: 30,
                      underline: SizedBox(),
                    ),
                  ),
                            //this._controller.chartData[0].isNotEmpty &&
                            //this._controller.chartData[1].isNotEmpty &&
                            //this._controller.chartData[2].isNotEmpty
                  Container(
                    child: (this._dataExists(this._controller.chartData))?
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                title.titleTest('assets/latency.svg', 'LATÊNCIA', Color.fromARGB(255, 255, 165, 0)),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 100,
                                  child:Sparkline(
                                    data: this._controller.chartData[0],
                                    lineColor: Color.fromARGB(255, 255, 165, 0),
                                    pointsMode: PointsMode.all,
                                    pointColor: Color.fromARGB(255, 255, 165, 0),
                                    fillMode: FillMode.below,
                                    fillColor: Color.fromARGB(120, 255, 165, 0),
                                  )
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                this._lineResults(Color.fromARGB(255, 255, 165, 0), this._controller.chartData[0], false),
                                SizedBox(
                                  height: 10,
                                ),
                                title.titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 100,
                                  child: Sparkline(
                                    data: this._controller.chartData[1],
                                    lineColor: Color.fromARGB(255, 250, 88, 88),
                                    pointsMode: PointsMode.all,
                                    pointColor: Color.fromARGB(255, 250, 88, 88),
                                    fillMode: FillMode.below,
                                    fillColor: Color.fromARGB(120, 250, 88, 88),
                                  )
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                this._lineResults(Color.fromARGB(255, 250, 88, 88), this._controller.chartData[1], true),
                                SizedBox(
                                  height: 10,
                                ),
                                title.titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 100,
                                  child: Sparkline(
                                    data: this._controller.chartData[2],
                                    lineColor: Color.fromARGB(255, 95, 180, 4),
                                    pointsMode: PointsMode.all,
                                    pointColor: Color.fromARGB(255, 95, 180, 4),
                                    fillMode: FillMode.below,
                                    fillColor: Color.fromARGB(120, 95, 180, 4),
                                  )
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                this._lineResults(Color.fromARGB(255, 95, 180, 4), this._controller.chartData[2], true),

                              ],
                            // Bloco de código onde mostra um erro de não haver dados para
                            // Levantar o gráfico
                            ):Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(":(", 
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 66, 115, 227),
                                      fontSize: 80
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("Não há dados suficentes!",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 66, 115, 227),
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            
                  )

                  ],
                ),
            )
          )
        );
      } ,
    );
  }

  @override
  void dispose(){
    super.dispose();
    this._controller.dispose();
  }

}
