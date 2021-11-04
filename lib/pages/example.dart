import 'package:basvuru_app/services/authenticationservice.dart';
import 'package:basvuru_app/services/firestoreservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  final _formAnahtari = GlobalKey<FormState>();

  String kullaniciid,
      basvuru_turu,
      ad_soyad,
      tc,
      adres,
      gsm,
      tel,
      mail,
      universite,
      fakulte,
      bolum,
      sinif,
      disiplin_cezasi,
      ogretim_turu,
      no,
      yerlesme_yili,
      yerlestirme_pt;
  int not, yd_puani;
  DateTime dt;
  bool yukleniyor = false;

  int _currentStep = 0;
  StepperType _stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Yatay Geçiş Başvuru Sayfası")),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: _stepperType,
              currentStep: _currentStep,
              physics: ScrollPhysics(),
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: canceled,
              steps: <Step>[
                Step(
                  //step 1
                  title: Text("Hesap İşlemleri"),
                  content: Column(
                    children: [
                      Column(
                        children: <Widget>[
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
                            onSaved: (girilenDeger) => ad_soyad = girilenDeger,
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
                            onSaved: (girilenDeger) =>
                                dt = girilenDeger as DateTime,
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
                            //tel
                            keyboardType: TextInputType.phone,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: "Telefon (EV/İŞ)",
                              labelText: "Telefon (EV/İŞ):",
                              errorStyle: TextStyle(fontSize: 16.0),
                            ),
                            validator: (girilenDeger) {
                              if (girilenDeger.isEmpty) {
                                return "Telefon (EV/İŞ) Alanı boş bırakılamaz!";
                              }
                              return null;
                            },
                            onSaved: (girilenDeger) => tel = girilenDeger,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ) //step1 sonu
                ,
                Step(
                  //step 2
                  title: Text("Hesap1 İşlemleri"),
                  content: Column(
                    children: <Widget>[
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
                        onSaved: (girilenDeger) => ad_soyad = girilenDeger,
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
                        onSaved: (girilenDeger) =>
                            dt = girilenDeger as DateTime,
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
                        //tel
                        keyboardType: TextInputType.phone,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: "Telefon (EV/İŞ)",
                          labelText: "Telefon (EV/İŞ):",
                          errorStyle: TextStyle(fontSize: 16.0),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Telefon (EV/İŞ) Alanı boş bırakılamaz!";
                          }
                          return null;
                        },
                        onSaved: (girilenDeger) => tel = girilenDeger,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ) //step2 sonu
                ,
                Step(
                  //step 3
                  title: Text("Hesap İşlemleri"),
                  content: Column(
                    children: <Widget>[
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
                        onSaved: (girilenDeger) => ad_soyad = girilenDeger,
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
                        onSaved: (girilenDeger) =>
                            dt = girilenDeger as DateTime,
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
                        //tel
                        keyboardType: TextInputType.phone,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: "Telefon (EV/İŞ)",
                          labelText: "Telefon (EV/İŞ):",
                          errorStyle: TextStyle(fontSize: 16.0),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Telefon (EV/İŞ) Alanı boş bırakılamaz!";
                          }
                          return null;
                        },
                        onSaved: (girilenDeger) => tel = girilenDeger,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ) //step3 sonu
                ,
                Step(
                  //step 4
                  title: Text("Hesap İşlemleri"),
                  content: Column(
                    children: <Widget>[
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
                        onSaved: (girilenDeger) => ad_soyad = girilenDeger,
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
                        onSaved: (girilenDeger) =>
                            dt = girilenDeger as DateTime,
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
                        //tel
                        keyboardType: TextInputType.phone,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: "Telefon (EV/İŞ)",
                          labelText: "Telefon (EV/İŞ):",
                          errorStyle: TextStyle(fontSize: 16.0),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Telefon (EV/İŞ) Alanı boş bırakılamaz!";
                          }
                          return null;
                        },
                        onSaved: (girilenDeger) => tel = girilenDeger,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          //     onPressed: _basvuru,
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
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ) //step4 sonu
              ],
            ),
          ),
        ],
      ),
    );
  }

  tapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  void canceled() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  void switchStepsType() {
    setState(() {
      _stepperType == StepperType.vertical
          ? _stepperType = StepperType.horizontal
          : _stepperType = StepperType.vertical;
    });
  }
}
