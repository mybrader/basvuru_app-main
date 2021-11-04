import 'package:basvuru_app/pages/forget_password.dart';
import 'package:basvuru_app/pages/login.dart';
import 'package:basvuru_app/pages/sign_in.dart';
import 'package:basvuru_app/redirection.dart';
import 'package:basvuru_app/services/authenticationservice.dart';
import 'package:flutter/material.dart';
import 'package:basvuru_app/pages/detail.dart';
import 'package:basvuru_app/pages/grid.dart';
import 'package:basvuru_app/pages/yaz_okulu_basvurusu.dart';
import 'package:basvuru_app/pages/yatay_gecis_basvurusu.dart';
import 'package:basvuru_app/pages/dgs_basvurusu.dart';
import 'package:basvuru_app/pages/cap_basvurusu.dart';
import 'package:basvuru_app/pages/ders_intibaki_basvurusu.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool aramaDurum = false;
  int secilenIndex = 0;
  var sayfaListesi = [
    GridViewSayfa(),
    YazOkulu(),
    YatayGecis(),
    Dgs(),
    capBasvurusu(),
    Dersintibaki(),
    LoginPage(),
    Signin(),
    ForgetPassword(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "KOU",
              style: TextStyle(fontSize: 22.0),
            ),
            Text("Başvuru Uygulaması", style: TextStyle(fontSize: 16.0))
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                tooltip: "Bilgi",
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  print("Bilgi Tıklandı");
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              child: Icon(Icons.more_vert),
              tooltip: "Popup Menu",
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Profil"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Destek"),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Çıkış"),
                ),
              ],
              onSelected: (menuItemValue) {
                if (menuItemValue == 1) {
                  print("Profil Tıklandı");
                }
                if (menuItemValue == 2) {
                  print("Destek Tıklandı");
                }
                if (menuItemValue == 3) {
                  _cikisYap();
                } else {
                  return "Popup Menu Tıklandı";
                }
              },
            ),
          )
        ],
      ),
      body: sayfaListesi[secilenIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(0, 40, 10, 0),
                child: Text(
                  "Başvuru Uygulaması",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            ListTile(
              title: Text("Yaz okulu başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Yatay geçiş başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("DGS başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("ÇAP başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Ders intibakı Başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("login"),
              onTap: () {
                setState(() {
                  secilenIndex = 6;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("sign in"),
              onTap: () {
                setState(() {
                  secilenIndex = 7;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Ders intibakı Başvurusu"),
              onTap: () {
                setState(() {
                  secilenIndex = 8;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _cikisYap() {
    Provider.of<AuthServices>(context, listen: false).cikisYap();
  }
}
