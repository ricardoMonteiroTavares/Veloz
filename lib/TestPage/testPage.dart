/**
 * Página responsável por mostrar os testes a serem realizados, dado um servidor de entrada.
 */

import 'package:Veloz/functions/titleTest.dart' as title;
import 'package:Veloz/functions/resultTest.dart' as result;
import 'package:Veloz/objects/customPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Veloz/TestPage/testPageController.dart';
import 'package:Veloz/objects/serverClass.dart';


class TestPage extends StatefulWidget{
  final Server serverTest;
  final String ipLocal;

  const TestPage(
    {
      Key key, 
      @required this.serverTest,    // Servidor para testes
      @required this.ipLocal,       // IP do Smartphone
    }
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>{
  final TestPageController _controller = TestPageController();

  @override
  void initState(){
    // Trecho responsável pelos testes de ping, download e upload 
    if(this._controller.result.pingAvg == null){
      this._controller.pingTest(widget.serverTest.dns);
      if(this._controller.result.pingAvg == -1){
        this._showDialogError();
      }
    }
    if(this._controller.result.downAvg == null){
      this._controller.downloadTest(widget.serverTest.host);
    }
    if(this._controller.result.upAvg == null){
      this._controller.uploadTest(widget.serverTest.host);
    }

    super.initState();
  }
  
  Future _showDialogError() async{
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ih, deu ruim :('),
        content: Text('Não conseguimos conectar no Servidor! \\n Tente novamente mais tarde.'),
        actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
        ],
      )
    );
  }

  // Função responsável pelo design tanto do servidor a ser testado, quanto para o ip do Smartphone 
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
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Testando'),
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
          body: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView( 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    // Bloco de códgigo responsável por mostrar tanto o servidor de teste com o seu dns
                    // quanto o Smartphone com o seu ip
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
                                this._connectInfo("Seu IP", widget.ipLocal, Color.fromARGB(255, 66, 115, 227)),
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
                    SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: <Widget>[
                        CustomPaint(
                          painter: CurvePainter(),
                          child: Container(height: 150),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 65,
                            ),
                            // Container responsável por mostrar o  resultado do teste de upload
                            Container(
                              child: Column(
                                children: <Widget>[
                                  title.titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                                  result.resultTest(this._controller.result.upAvg, Color.fromARGB(255, 95, 180, 4), true, true),
                                ],
                              ),
                            ),

                            // Container responsável por mostrar o  resultado do teste de download
                            Container(
                              child: Column(
                                children: <Widget>[
                                  title.titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
                                  result.resultTest(this._controller.result.downAvg, Color.fromARGB(255, 250, 88, 88), true, true),
                                ],
                              ),
                            ),

                            // Container responsável por mostrar o  resultado do teste de ping
                            Container(
                              child: Column(
                                children: <Widget>[
                                  title.titleTest('assets/ping.svg', 'PING', Color.fromARGB(255, 255, 165, 0)),
                                  result.resultTest(this._controller.result.pingAvg, Color.fromARGB(255, 255, 165, 0), false, true),
                                ],
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),

                    // É o botão onde só é visível e funcional qunado termina os testes
                    Visibility(
                      visible: ((this._controller.result.upAvg != null) && (this._controller.result.downAvg != null) && (this._controller.result.pingAvg != null)),
                      child: Row(
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
                              onPressed: () async{
                                bool flag = await this._controller.saveResult(widget.serverTest.id);
                                if(flag){
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                  ]
                ),
              )
            )
          ),
        );
      }
    ); 
    
  }

  @override
  void dispose(){
    super.dispose();
    this._controller.dispose();
  }
}
