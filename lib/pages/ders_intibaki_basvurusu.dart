import 'package:flutter/material.dart';

class Dersintibaki extends StatefulWidget {
  @override
  _DersintibakiState createState() => _DersintibakiState();
}

class _DersintibakiState extends State<Dersintibaki> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Ders İntibakı Başvuru Sayfası")),
      ),
      body: Center(child: Text("Ders İntibakı Sayfası")),
    );
  }
}
