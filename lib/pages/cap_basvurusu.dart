import 'package:flutter/material.dart';

class capBasvurusu extends StatefulWidget {
  @override
  _capBasvurusuState createState() => _capBasvurusuState();
}

class _capBasvurusuState extends State<capBasvurusu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Çap Başvurusu Başvuru Sayfası")),
      ),
      body: Center(child: Text("Çap Başvurusu Sayfası")),
    );
  }
}
