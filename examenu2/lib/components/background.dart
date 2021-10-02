import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child; //Null safety
  const Background({Key? key, required this.child})
      : super(key: key); //Recibe un atributo requerido

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top1.png',
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top2.png',
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Image.asset(
              'assets/images/main.png',
              width: size.width * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bottom1.png',
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bottom2.png',
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          child
        ],
      ),
    );
  }
}
