import 'package:basvuru_app/models/ygbasvuru.dart';
import 'package:basvuru_app/pages/example.dart';
import 'package:basvuru_app/pages/sign_in.dart';
import 'package:basvuru_app/pages/yatay_gecis_basvurusu.dart';
import 'package:basvuru_app/pages/yaz_okulu_basvurusu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/users.dart';
import 'pages/homepage.dart';
import 'pages/login.dart';
import 'services/authenticationservice.dart';

class Yonlendirme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _yetkilendirmeServisi =
        Provider.of<AuthServices>(context, listen: false);

    return StreamBuilder(
        stream: _yetkilendirmeServisi.durumTakipcisi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            Kullanici aktifKullanici = snapshot.data;
            _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici.id;
            return YatayGecis();
          } else {
            return LoginPage();
          }
        });
  }
}
