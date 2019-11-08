// Função respnsável por gerar o design dos títulos dos testes
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget titleTest(String icon, String type, Color color){
  double sizeIcon = 35;
  double sizeFont = 20;
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
