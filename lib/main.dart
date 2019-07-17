/*
 * Created by Alfonso Cejudo, Wednesday, July 17th 2019.
 */

import 'package:flutter/material.dart';
import 'package:aperture_demo/aperture/aperture.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aperture Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Aperture Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Colors.black,
              ),
              Image.asset(
                'images/bay.png',
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: 300.0,
                height: 300.0,
                child: Aperture(
                  child: Image.asset('images/dope.png'),
                ),
              ),
            ],
          ),
        ));
  }
}
