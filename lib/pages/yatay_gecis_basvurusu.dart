import 'package:basvuru_app/models/ygbasvuru.dart';
import 'package:basvuru_app/services/authenticationservice.dart';
import 'package:basvuru_app/services/firestoreservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YatayGecis extends StatefulWidget {
  @override
  _YatayGecisState createState() => _YatayGecisState();
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class _YatayGecisState extends State<YatayGecis> {
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari =
      GlobalKey<ScaffoldState>(); //snack için state kontrolu
  bool yukleniyor = false;
  String kullaniciId,
      basvuruTuru,
      adSoyad,
      tc,
      adres,
      gsm,
      tel,
      mail,
      universite,
      fakulte,
      bolum,
      sinif,
      disiplinCezasi,
      ogretimTuru,
      no,
      yerlesmeYili,
      yerlestirmePt,
      bfakulte,
      bbolum,
      bogretimTuru;
  int not, ydPuani;
  DateTime dt;

  String _secilenbt = null;
  List<String> _tumbt = [
    "Kurumiçi Yatay Geçiş Başvurusu",
    "Mer.Yer. Puanıyla Yatay Geçiş Başvurusu",
    "Kurumlarası Yatay Geçiş Başvurusu",
    "Yurtdışı Yatay Geçiş Başvurusu"
  ];
  String _secilendp = null;
  List<String> _tumdp = [
    'Disiplin Cezası Alındı',
    'Disiplin Cezası Yok',
  ];
  String _secilenot = null;
  String _secilenbot = null;
  List<String> _tumot = [
    '1.Öğretim',
    '2.Öğretim',
  ];
  List<String> bs = [];
  List<String> bbs = [];
  String _secilenfk;
  String _secilenbl;
  String _secilenbfk;
  String _secilenbbl;
  List<String> _tumfk = [
    'Eğitim Fakültesi',
    'Fen Edebiyat Fakültesi',
    'Mühendislik Fakültesi',
    'Spor Bilimleri Fakültesi',
    'İktisadi ve İdari Bilimler Fakültesi',
    'Güzel Sanatlar Fakültesi',
  ];
  List<String> _efk = [
    'Fen Bilgisi Öğretmenliği',
    'İlköğretim Matematik Öğretmenliği',
    'İngilizce Öğretmenliği',
    'Okul Öncesi Öğretmenliği',
    'Rehberlik ve Psikolojik Danışmanlık',
    'Sınıf Öğretmenliği',
    'Türkçe Öğretmenliği',
  ];
  List<String> _ffk = [
    'Arkeolojii',
    'Biyoloji ',
    'Felsefe',
    'Fizik',
    'Kimya',
    'Matematik',
    'Tarih',
    'Türk Dili ve Edebiyatı',
  ];
  List<String> _mfk = [
    'Elektrik Mühendisliği',
    'Endüstri Mühendisliği ',
    'Harita Mühendisliği',
    'İnşaat Mühendisliği',
    'Jeofizik Mühendisliği',
    'Kimya Mühendisliği',
    'Makine Mühendisliği',
    'Mekatronik Mühendisliği',
  ];
  List<String> _sfk = [
    'Antrenörlük Eğitimi',
    'Antrenörlük Eğitimi (İÖ) ',
    'Beden Eğitimi ve Spor Öğretmenliği',
    'Spor Yöneticiliği',
    'Spor Yöneticiliği (İÖ)',
    'Rekreasyon',
    'Rekreasyon (İÖ)',
  ];
  List<String> _ifk = [
    'İşletme',
    'İşletme (İÖ) ',
    'İktisat',
    'İktisat (İÖ)',
    'Çalışma Ekonomisi ve Endüstri İlişkileri',
    'Siyaset Bilimi ve Kamu Yönetimi',
    'Uluslararası İlişkiler',
  ];
  List<String> _gfk = [
    'Fotoğraf',
    'Grafik Tasarımı',
    'Heykel',
    'Müzikoloji',
    'Oyunculuk',
    'Performans',
    'Resim',
    'Seramik',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Yatay Geçiş Başvuru Sayfası")),
      ),
      body: ListView(
        children: <Widget>[
          yukleniyor
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0.0,
                ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
                key: _formAnahtari,
                child: Column(
                  children: <Widget>[
                    Text(
                      'I- BAŞVURU TÜRÜ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text(
                        'Başvuru Türü',
                        style: TextStyle(fontSize: 20),
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),
                      items: _tumbt
                          .map(
                            (String oankibt) => DropdownMenuItem(
                              child: Text(oankibt),
                              value: oankibt,
                            ),
                          )
                          .toList(),
                      value: _secilenbt,
                      onChanged: (String yeni) {
                        setState(() {
                          _secilenbt = yeni;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'II- KİŞİSEL BİLGİLER',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //Ad Soyad
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Ad Soyad",
                        labelText: "Ad Soyad:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "İsim Soyisim Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => adSoyad = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //tc
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "T.C. Kimlik No Giriniz",
                        labelText: "T.C. Kimlik No:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "T.C. Kimlik No alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => tc = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //doğum tarihi
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Doğum Tarihi Giriniz",
                        labelText: "Doğum Tarihi:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Doğum Tarihi alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => dt = girilenDeger as DateTime,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //mail
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email adresinizi girin",
                        labelText: "Mail:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Email alanı boş bırakılamaz!";
                        } else if (!girilenDeger.contains("@")) {
                          return "Girilen değer mail formatında olmalı!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => mail = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Adres",
                        labelText: "Adres:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Adres Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => adres = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //tel
                      keyboardType: TextInputType.phone,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Telefon (GSM)",
                        labelText: "Telefon (GSM):",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Telefon (GSM) Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => gsm = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //tel ev
                      keyboardType: TextInputType.phone,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Telefon(EV/İŞ) ",
                        labelText: "Telefon (EV/İŞ) :",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      onSaved: (girilenDeger) => tel = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'III- ÖĞRENİMİNE İLİŞKİN BİLGİLER',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text(
                        'Disiplin Cezası Alındı mı?',
                        style: TextStyle(fontSize: 20),
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),
                      items: _tumdp
                          .map(
                            (String oankidp) => DropdownMenuItem(
                              child: Text(oankidp),
                              value: oankidp,
                            ),
                          )
                          .toList(),
                      value: _secilendp,
                      onChanged: (String yeni) {
                        setState(() {
                          _secilendp = yeni;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      hint: Text('Fakülte'),
                      value: _secilenfk,
                      isExpanded: true,
                      items: _tumfk.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (c) {
                        if (c == 'Eğitim Fakültesi') {
                          bs = _efk;
                        } else if (c == 'Fen Edebiyat Fakültesi') {
                          bs = _ffk;
                        } else if (c == 'Fen Edebiyat Fakültesi') {
                          bs = _ffk;
                        } else if (c == 'Mühendislik Fakültesi') {
                          bs = _mfk;
                        } else if (c == 'Spor Bilimleri Fakültesi') {
                          bs = _sfk;
                        } else if (c ==
                            'İktisadi ve İdari Bilimler Fakültesi') {
                          bs = _ifk;
                        } else if (c == 'Güzel Sanatlar Fakültesi') {
                          bs = _gfk;
                        } else {
                          bs = [];
                        }
                        setState(() {
                          _secilenbl = null;
                          _secilenfk = c;
                        });
                      },
                    ),
                    // Province Dropdown
                    DropdownButton<String>(
                      hint: Text('Bölüm'),
                      value: _secilenbl,
                      isExpanded: true,
                      items: bs.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (p) {
                        setState(() {
                          _secilenbl = p;
                        });
                      },
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //sınıf
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Kayıtlı Olduğu Sınıf",
                        labelText: "Kayıtlı Olduğu Sınıf:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Kayıtlı Olduğu Sınıf Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => sinif = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DropdownButton(
                      hint: Text(
                        'Öğretim Türü',
                        style: TextStyle(fontSize: 20),
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),
                      items: _tumot
                          .map(
                            (String oankiot) => DropdownMenuItem(
                              child: Text(oankiot),
                              value: oankiot,
                            ),
                          )
                          .toList(),
                      value: _secilenot,
                      onChanged: (String yeni) {
                        setState(() {
                          _secilenot = yeni;
                        });
                      },
                    ),
                    TextFormField(
                      //no
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Öğrenci Numarası",
                        labelText: "Öğrenci Numarası:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Öğrenci Numarası Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => no = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //yerlesmeYili
                      keyboardType: TextInputType.datetime,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Yerleşme Yılı",
                        labelText: "Yerleşme Yılı:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Yerleşme Yılı Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => yerlesmeYili = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //yerlestirmePt
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Yerleştirme Puan Türü",
                        labelText: "Yerleştirme Puan Türü:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Yerleştirme Puan Türü Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => yerlestirmePt = girilenDeger,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //Not Ortalaması
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Not Ortalaması",
                        labelText: "Not Ortalaması:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.isEmpty) {
                          return "Not Ortalaması Alanı boş bırakılamaz!";
                        }
                        return null;
                      },
                      onSaved: (girilenDeger) => not = girilenDeger as int,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      //yabancı dil puanı
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Yabancı Dil Puanı",
                        labelText: "Yabancı Dil Puanı:",
                        errorStyle: TextStyle(fontSize: 16.0),
                      ),

                      onSaved: (girilenDeger) => ydPuani = girilenDeger as int,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'IV– ADAYIN BAŞVURDUĞU YÜKSEKÖĞRETİM PROGRAMINA İLİŞKİN BİLGİLER',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),

                    DropdownButton<String>(
                      hint: Text('Fakülte'),
                      value: _secilenbfk,
                      isExpanded: true,
                      items: _tumfk.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (c) {
                        if (c == 'Eğitim Fakültesi') {
                          bbs = _efk;
                        } else if (c == 'Fen Edebiyat Fakültesi') {
                          bbs = _ffk;
                        } else if (c == 'Fen Edebiyat Fakültesi') {
                          bbs = _ffk;
                        } else if (c == 'Mühendislik Fakültesi') {
                          bbs = _mfk;
                        } else if (c == 'Spor Bilimleri Fakültesi') {
                          bbs = _sfk;
                        } else if (c ==
                            'İktisadi ve İdari Bilimler Fakültesi') {
                          bbs = _ifk;
                        } else if (c == 'Güzel Sanatlar Fakültesi') {
                          bbs = _gfk;
                        } else {
                          bbs = [];
                        }
                        setState(() {
                          _secilenbbl = null;
                          _secilenbfk = c;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      hint: Text('Bölüm'),
                      value: _secilenbbl,
                      isExpanded: true,
                      items: bs.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (p) {
                        setState(() {
                          _secilenbbl = p;
                        });
                      },
                    ),

                    DropdownButton(
                      hint: Text(
                        'Öğretim Türü',
                        style: TextStyle(fontSize: 20),
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      style: TextStyle(color: Colors.black),
                      items: _tumot
                          .map(
                            (String oankiot) => DropdownMenuItem(
                              child: Text(oankiot),
                              value: oankiot,
                            ),
                          )
                          .toList(),
                      value: _secilenbot,
                      onChanged: (yeni) {
                        setState(() {
                          _secilenbot = yeni;
                        });
                      },
                    ),

                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: _basvuru,
                        child: Text(
                          "Başvur",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _basvuru() async {
    String aktifKullaniciId =
        Provider.of<AuthServices>(context, listen: false).aktifKullaniciId;

    var _formState = _formAnahtari.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        FireStoreService().ygBasvuru(
          kullaniciId: aktifKullaniciId,
          basvuruTuru: basvuruTuru,
          adSoyad: adSoyad,
          tc: tc,
          adres: adres,
          gsm: gsm,
          tel: tel,
          mail: mail,
          universite: universite,
          fakulte: fakulte,
          bolum: bolum,
          sinif: sinif,
          disiplinCezasi: disiplinCezasi,
          ogretimTuru: ogretimTuru,
          no: no,
          yerlesmeYili: yerlesmeYili,
          yerlestirmePt: yerlestirmePt,
          not: not,
          ydPuani: ydPuani,
          dt: dt,
          bfakulte: bfakulte,
          bbolum: bbolum,
          bogretimTuru: bogretimTuru,
        );

        Navigator.pop(context);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
      }
    }
  }

  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "email-already-in-use") {
      hataMesaji = "Girdiğiniz mail kayıtlıdır";
    } else if (hataKodu == "weak-password") {
      hataMesaji = "Daha zor bir şifre tercih edin";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState.showSnackBar(snackBar);
  }
}
