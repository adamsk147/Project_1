import 'package:flutter/material.dart';

class MyStyle {
  Color dakColor = Color(0xff005400);
  Color primaryColor = Color(0xff39821a);
  Color lightColor = Color(0xff6bb249);

  Widget showLogo() => Image(
        image: AssetImage('assets/image/lov_1.png'),
      );

  Color primaryTextColor = Color(0xFF414C6B);
  Color secondaryTextColor = Color(0xFFE4979E);
  Color titleTextColor = Colors.white;
  Color contentTextColor = Color(0xff868686);
  Color navigationColor = Color(0xFF6751B5);
  Color gradientStartColor = Color(0xFF0050AC);
  Color gradientEndColor = Color(0xFF9354B9);

  TextStyle darStyle() => TextStyle(color: dakColor);
  TextStyle whitStyle() => TextStyle(color: Colors.white);
  TextStyle pinkStyle() => TextStyle(
      color: Colors.pink.shade300, fontWeight: FontWeight.w700, fontSize: 17);

  SafeArea buildBackground(double screenWidth, double screenHeight) {
    return SafeArea(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image(image: AssetImage('assets/image/top1.png')),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image(image: AssetImage('assets/image/top2.png')),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image(image: AssetImage('assets/image/bottom1.png')),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image(image: AssetImage('assets/image/bottom2.png')),
            ),
          ],
        ),
      ),
    );
  }

  MyStyle();
}
