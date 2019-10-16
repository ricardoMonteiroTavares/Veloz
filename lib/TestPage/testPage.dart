/**
 * Página responsável por mostrar os testes a serem realizados, dado um servidor de entrada.
 */

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
    }
    if(this._controller.result.downAvg == null){
      this._controller.downloadTest(widget.serverTest.host);
    }
    if(this._controller.result.upAvg == null){
      this._controller.uploadTest(widget.serverTest.host);
    }

    super.initState();
  }

  // Função respnsável por gerar o design dos títulos dos testes 
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

  // Função responsável por mostrar os resultados a serem obtidos pelos testes
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
    // TODO: implement build
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    // Bloco de códgigo responsável por mostrar tanto o servidor de teste com o seu dns
                    // quanto o Smartphone com o seu ip
                    Row(
                      children: <Widget>[
                        ListTile(
                          leading: SvgPicture.asset(widget.serverTest.icon, height: 40),
                          title: Text(
                            widget.serverTest.name,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 18,
                              color: Color.fromARGB(255, 66, 115, 227),
                            ),
                          ),

                          subtitle: Text(
                            widget.serverTest.dns,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              //fontSize: (RenderFlex().),
                              color: Color.fromARGB(255, 66, 115, 227),
                            ),
                          ),
                        ),
                        ListTile(
                          trailing: SvgPicture.asset("assets/smartphone.svg", height: 40),
                          title: Text(
                            'Seu IP',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 18,
                              color: Color.fromARGB(255, 66, 115, 227),
                            ),
                          ),

                          subtitle: Text(
                            widget.ipLocal,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              //fontSize: (RenderFlex().),
                              color: Color.fromARGB(255, 66, 115, 227),
                            ),
                          ),
                        )
                        /*
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
                        ),*/
                      ],
                    ),
                    // Container responsável por mostrar o  resultado do teste de upload
                    Container(
                      child: Column(
                        children: <Widget>[
                          this._titleTest('assets/upload.svg', 'UPLOAD', Color.fromARGB(255, 95, 180, 4)),
                          this._resultTest(this._controller.result.upAvg, Color.fromARGB(255, 95, 180, 4), true),
                        ],
                      ),
                    ),

                    // Container responsável por mostrar o  resultado do teste de download
                    Container(
                      child: Column(
                        children: <Widget>[
                          this._titleTest('assets/download.svg', 'DOWNLOAD', Color.fromARGB(255, 250, 88, 88)),
                          this._resultTest(this._controller.result.downAvg, Color.fromARGB(255, 250, 88, 88), true),
                        ],
                      ),
                    ),

                    // Container responsável por mostrar o  resultado do teste de ping
                    Container(
                      child: Column(
                        children: <Widget>[
                          this._titleTest('assets/ping.svg', 'PING', Color.fromARGB(255, 255, 165, 0)),
                          this._resultTest(this._controller.result.pingAvg, Color.fromARGB(255, 255, 165, 0), false),
                        ],
                      ),
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