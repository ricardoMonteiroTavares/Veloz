import 'package:flutter/material.dart';
// Função responsável por mostrar os resultados a serem obtidos pelos testes
// A variável de entrada page serve para destinguir se a função é chamada na 
// página de teste (true) ou de histórico (false) 
Widget resultTest(int value, Color color, bool type, bool page){
    String metric = (type)? 'kbps' : 'ms';
    
    double sizeFont = (page)? 50 : 25;

    return RichText(
      text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: (value == null)? '--' : value.toString(),
                style: TextStyle(
                  fontFamily: 'Offside',
                  fontSize: sizeFont,
                  color: color,
                )
            ),
            TextSpan(
                text: (value == null)? '' : metric,
                style: TextStyle(
                  fontFamily: 'Open Sans Condensed',
                  fontSize: (sizeFont/2),
                  color: color,
                )
            ),
          ]
      ),
    );
  }