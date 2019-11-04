// Função respnsável por gerar o design dos títulos dos testes
// A variável de entrada page serve para destinguir se a função é chamada na 
// página de teste (true) ou de histórico (false) 
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget titleTest(String icon, String type, Color color, bool page){
  double sizeIcon = (page)? 25 : 40;
  double sizeFont = (page)? 16 : 20;
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(icon, height: sizeIcon, width: sizeIcon,),
        SizedBox(
          width: 15,
        ),
        Text(
          type,
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: sizeFont,
            color: color,
          ),
        )
      ],
    );
  }
