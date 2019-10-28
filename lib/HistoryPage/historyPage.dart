import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    this._controller.buildServers();
    this._controller.onChangeItem(this._controller.dropdownMenuItems[0].value);
    
    super.initState();
  }

  Widget _titleTest(String icon, String type, Color color){
    return Row(
          mainAxisAlignment: MainAxisAlignment.start,
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

  Widget _resultTest(int value, Color color, bool type){
    String metric;
    if(type){
      metric = 'kbps';
    }else{
      metric = 'ms';
    }
    return RichText(
      text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: (value == null)? '--' : value.toString(),
                style: TextStyle(
                  fontFamily: 'Offside',
                  fontSize: 25,
                  color: color,
                )
            ),
            TextSpan(
                text: (value == null)? '' : metric,
                style: TextStyle(
                  fontFamily: 'Open Sans Condensed',
                  fontSize: 12,
                  color: color,
                )
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
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

                  Container(
                    child: (this._controller.chartData[0].isNotEmpty &&
                            this._controller.chartData[1].isNotEmpty &&
                            this._controller.chartData[2].isNotEmpty)?
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                this._titleTest('assets/ping.svg', 'PING', Color.fromARGB(255, 255, 165, 0)),
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
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("MÍN",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 255, 165, 0),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.minimal(this._controller.chartData[0]),
                                              Color.fromARGB(255, 255, 165, 0),
                                              false
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÉD",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 255, 165, 0),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.avg(this._controller.chartData[0]),
                                              Color.fromARGB(255, 255, 165, 0),
                                              false
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÁX",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 255, 165, 0),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.maximal(this._controller.chartData[0]),
                                              Color.fromARGB(255, 255, 165, 0),
                                              false
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                this._titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
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
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("MÍN",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 250, 88, 88),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.minimal(this._controller.chartData[1]),
                                              Color.fromARGB(255, 250, 88, 88),
                                              true
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÉD",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 250, 88, 88),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.avg(this._controller.chartData[1]),
                                              Color.fromARGB(255, 250, 88, 88),
                                              true
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÁX",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 250, 88, 88),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.maximal(this._controller.chartData[1]),
                                              Color.fromARGB(255, 250, 88, 88),
                                              true
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                this._titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
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
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("MÍN",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 95, 180, 4),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.minimal(this._controller.chartData[2]),
                                              Color.fromARGB(255, 95, 180, 4),
                                              true
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÉD",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 95, 180, 4),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.avg(this._controller.chartData[2]),
                                              Color.fromARGB(255, 95, 180, 4),
                                              true
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("MÁX",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 95, 180, 4),
                                              )
                                          ),
                                          this._resultTest(
                                              this._controller.maximal(this._controller.chartData[2]),
                                              Color.fromARGB(255, 95, 180, 4),
                                              true
                                          ),
                                        ],
                                      ),
                                    ]
                                ),

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
                                  Text("Não contém dados!",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 66, 115, 227),
                                      fontSize: 30
                                    ),
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
