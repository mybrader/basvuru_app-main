import 'package:flutter/material.dart';

import 'detail.dart';

class GridViewSayfa extends StatefulWidget {
  @override
  _GridViewSayfaState createState() => _GridViewSayfaState();
}

class _GridViewSayfaState extends State<GridViewSayfa> {
  var basvurular = [
    "Yaz okulu başvurusu",
    "Yatay geçiş başvurusu",
    "DGS başvurusu",
    "ÇAP başvurusu",
    "Ders intibakı",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Başvurular"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
        ),
        itemCount: basvurular.length,
        itemBuilder: (context, indeks) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            ulkeadi: basvurular[indeks],
                          )));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 30),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            print("Text ile ${basvurular[indeks]} seçildi");
                          },
                          child: Text(basvurular[indeks])),
                      Spacer(),
                      PopupMenuButton(
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text("Sil"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text("Güncelle"),
                          ),
                        ],
                        onSelected: (menuItemValue) {
                          if (menuItemValue == 1) {
                            print("${basvurular[indeks]} silindi");
                          }
                          if (menuItemValue == 2) {
                            print("${basvurular[indeks]} Güncellendi");
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
