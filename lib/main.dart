import 'package:flutter/material.dart';
import './widgets/userTransaction.dart';



void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false, //Remove at the end
      appBar: AppBar(
        title: Text('Track Expenses'),
      ),
      body: SingleChildScrollView(
       child:
       Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.blue,
              child: Text('Chart',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              elevation: 120,
            ),
          ),
          UserTransaction(),
        ],
      ),
    ));
  }
}
