import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veloz/TestPage/testPageController.dart';


class TestPage extends StatefulWidget{
  final String ipTest;
  final String hostTest;

  const TestPage(
    {
      Key key, 
      @required this.ipTest,
      @required this.hostTest,
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
      this._controller.pingTest(widget.ipTest);
    }
    if(this._controller.downAvg == null){
      this._controller.downloadTest(widget.hostTest);
    }
    if(this._controller.upAvg == null){
      this._controller.uploadTest(widget.hostTest);
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
                        text: 'kbps',
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
                        text: 'kbps',
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
                        text: 'ms',
                        style: TextStyle(
                          fontFamily: 'Open Sans Condensed',
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 165, 0),
                        )
                      ),
                    ]
                  ),
                ),  
              ]
            ),
          ),
        );
      }
    ); 
    
  }

}