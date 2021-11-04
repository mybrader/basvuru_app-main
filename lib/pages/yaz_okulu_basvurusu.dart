import 'package:flutter/material.dart';

class YazOkulu extends StatefulWidget {
  @override
  _YazOkuluState createState() => _YazOkuluState();
}

class _YazOkuluState extends State<YazOkulu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Yaz Okulu Başvuru Sayfası")),
      ),
      body: Center(child: Text("Yaz Okulu Sayfası")),
    );
  }
}
