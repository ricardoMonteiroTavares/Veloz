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
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
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
                    //this._emptyChart(this._controller.chartData)

                    (this._controller.chartData[0].isNotEmpty)?
                    Column(
                      children: <Widget>[
                        this._titleTest('assets/ping.svg', 'PING', Color.fromARGB(255, 255, 165, 0)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          child:(this._controller.chartData[0].isNotEmpty)? Sparkline(
                            data: this._controller.chartData[0],
                            lineColor: Color.fromARGB(255, 255, 165, 0),
                            pointsMode: PointsMode.all,
                            pointColor: Color.fromARGB(255, 255, 165, 0),
                            fillMode: FillMode.below,
                            fillColor: Color.fromARGB(120, 255, 165, 0),
                          ) : Text("Não existe dados"),
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
                                this._resultTest((this._controller.avg(this._controller.chartData[0]) - this._controller.standardDeviation(this._controller.chartData[0])), Color.fromARGB(255, 255, 165, 0), false),
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
                                this._resultTest(this._controller.avg(this._controller.chartData[0]), Color.fromARGB(255, 255, 165, 0), false),
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
                                this._resultTest((this._controller.avg(this._controller.chartData[0]) + this._controller.standardDeviation(this._controller.chartData[0])), Color.fromARGB(255, 255, 165, 0), false),
                              ],
                            ),
                          ]
                        ),

                        this._titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          child:(this._controller.chartData[1].isNotEmpty)? Sparkline(
                            data: this._controller.chartData[1],
                            lineColor: Color.fromARGB(255, 250, 88, 88),
                            pointsMode: PointsMode.all,
                            pointColor: Color.fromARGB(255, 250, 88, 88),
                            fillMode: FillMode.below,
                            fillColor: Color.fromARGB(120, 250, 88, 88),
                          ) : Text("Não existe dados"),
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
                                  this._resultTest((this._controller.avg(this._controller.chartData[1]) - this._controller.standardDeviation(this._controller.chartData[1])), Color.fromARGB(255, 250, 88, 88), true),
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
                                  this._resultTest(this._controller.avg(this._controller.chartData[1]), Color.fromARGB(255, 250, 88, 88), true),
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
                                  this._resultTest((this._controller.avg(this._controller.chartData[1]) + this._controller.standardDeviation(this._controller.chartData[1])), Color.fromARGB(255, 250, 88, 88), true),
                                ],
                              ),
                            ]
                        ),
                        this._titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          child:(this._controller.chartData[2].isNotEmpty)? Sparkline(
                            data: this._controller.chartData[2],
                            lineColor: Color.fromARGB(255, 95, 180, 4),
                            pointsMode: PointsMode.all,
                            pointColor: Color.fromARGB(255, 95, 180, 4),
                            fillMode: FillMode.below,
                            fillColor: Color.fromARGB(120, 95, 180, 4),
                          ) : Text("Não existe dados"),
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
                                  this._resultTest((this._controller.avg(this._controller.chartData[2]) - this._controller.standardDeviation(this._controller.chartData[2])), Color.fromARGB(255, 95, 180, 4), true),
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
                                  this._resultTest(this._controller.avg(this._controller.chartData[2]), Color.fromARGB(255, 95, 180, 4), true),
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
                                  this._resultTest((this._controller.avg(this._controller.chartData[2]) + this._controller.standardDeviation(this._controller.chartData[2])), Color.fromARGB(255, 95, 180, 4), true),
                                ],
                              ),
                            ]
                        ),

                      ],
                    ): Text("Não existe dados"),
                  ],
                ),
            )
          )
        );
      } ,
    );
  }

}
