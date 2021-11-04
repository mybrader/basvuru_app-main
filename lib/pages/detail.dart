import 'package:flutter/material.dart';

class Detail extends StatelessWidget {

  String ulkeadi;
  Detail({this.ulkeadi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detay"),
        ),
        body: Center(
          child: Text("${ulkeadi}",style: TextStyle(fontSize: 100),),
        )

    );
  }
}
