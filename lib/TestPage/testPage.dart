import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veloz/TestPage/testPageController.dart';
import 'package:veloz/objects/serverClass.dart';


class TestPage extends StatefulWidget{
  final Server serverTest;
  final String ipLocal;

  const TestPage(
    {
      Key key, 
      @required this.serverTest,
      @required this.ipLocal,
    }
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  final TestPageController _controller = TestPageController();

  @override
  void initState(){
    if(this._controller.pingAvg == null){
      this._controller.pingTest(widget.serverTest.dns);
    }
    if(this._controller.downAvg == null){
      this._controller.downloadTest(widget.serverTest.host);
    }
    if(this._controller.upAvg == null){
      this._controller.uploadTest(widget.serverTest.host);
    }

    super.initState();
  }

  Widget _titleTest(String icon, String type, Color color){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(icon, height: 25, width: 25,),
            SizedBox(
              width: 15,
            ),
            Text(
              type,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
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
                  fontSize: 50,
                  color: color,
                )
              ),
              TextSpan(
                text: (value == null)? '' : metric,
                style: TextStyle(
                  fontFamily: 'Open Sans Condensed',
                  fontSize: 25,
                  color: color,
                )
              ),
            ]
          ),
        );              
  }

  Widget _connectInfo(String name, String dns, Color color){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 18,
              color: color,
            ),
          ),
          Text(
            dns,
            style: TextStyle(
              fontFamily: 'Open Sans',
              //fontSize: (RenderFlex().),
              color: color,
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Testando',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 30,
                    color: Color.fromARGB(255, 66, 115, 227),

                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SvgPicture.asset(widget.serverTest.icon, height: 40),
                              ],
                            ),
                            SizedBox(
                                  width: 5,
                            ),
                            this._connectInfo(widget.serverTest.name, widget.serverTest.dns, Color.fromARGB(255, 66, 115, 227)),
                            
                          ],
                        ),
                      ),
                    ),
                    
                    Container(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            this._connectInfo("Seu IP", "127.0.1", Color.fromARGB(255, 66, 115, 227)),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: <Widget>[
                                SvgPicture.asset("assets/smartphone.svg", height: 40),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                this._titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                this._resultTest(this._controller.upAvg, Color.fromARGB(255, 95, 180, 4), true),
                
                this._titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
                this._resultTest(this._controller.downAvg, Color.fromARGB(255, 250, 88, 88), true),
                
                this._titleTest('assets/ping.svg', 'PING', Color.fromARGB(255, 255, 165, 0)),
                this._resultTest(this._controller.pingAvg, Color.fromARGB(255, 255, 165, 0), false),
                
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        color: Color.fromARGB(255, 66, 115, 227),
                        child: Text('Finalizar',
                          style: TextStyle(
                              color: Colors.white,
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
              ]
            ),
          ),
        );
      }
    ); 
    
  }

}