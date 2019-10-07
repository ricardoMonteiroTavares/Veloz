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
                                  width: 3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.serverTest.name,
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 66, 115, 227),

                                  ),
                                ),
                                
                                Text(
                                  widget.serverTest.dns,
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    //fontSize: (RenderFlex().),
                                    color: Color.fromARGB(255, 66, 115, 227),
                                  ),
                                ),
                              ],
                            )
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
                            Column(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Seu IP",
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 66, 115, 227),
                                  ),
                                ),
                                
                                Text(
                                  "127.0.1",
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    //fontSize: 16,
                                    color: Color.fromARGB(255, 66, 115, 227),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 3,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/upload.svg', height: 25, width: 25,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'UPLOAD',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        color: Color.fromARGB(255, 95, 180, 4),
                      ),
                    )
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: (this._controller.upAvg == null)? '--' : this._controller.upAvg.toString(),
                        style: TextStyle(
                          fontFamily: 'Offside',
                          fontSize: 50,
                          color: Color.fromARGB(255, 95, 180, 4),
                        )
                      ),
                      TextSpan(
                        text: (this._controller.upAvg == null)? '' : 'kbps',
                        style: TextStyle(
                          fontFamily: 'Open Sans Condensed',
                          fontSize: 25,
                          color: Color.fromARGB(255, 95, 180, 4),
                        )
                      ),
                    ]
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/download.svg', height: 25, width: 25,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'DOWNLOAD',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        color: Color.fromARGB(255, 250, 88, 88),
                      ),
                    )
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: (this._controller.downAvg == null)? '--' : this._controller.downAvg.toString(),
                        style: TextStyle(
                          fontFamily: 'Offside',
                          fontSize: 50,
                          color: Color.fromARGB(255, 250, 88, 88),
                        )
                      ),
                      TextSpan(
                        text: (this._controller.downAvg == null)? '' : 'kbps',
                        style: TextStyle(
                          fontFamily: 'Open Sans Condensed',
                          fontSize: 25,
                          color: Color.fromARGB(255, 250, 88, 88),
                        )
                      ),
                    ]
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/ping.svg', height: 25, width: 25,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'PING',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 165, 0),
                      ),
                    )
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: (this._controller.pingAvg == null)? '--' : this._controller.pingAvg.toString(),
                        style: TextStyle(
                          fontFamily: 'Offside',
                          fontSize: 50,
                          color: Color.fromARGB(255, 255, 165, 0),
                        )
                      ),
                      TextSpan(
                        text: (this._controller.pingAvg == null)? '' : 'ms',
                        style: TextStyle(
                          fontFamily: 'Open Sans Condensed',
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 165, 0),
                        )
                      ),
                    ]
                  ),
                ),
                
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