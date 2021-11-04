import 'package:cloud_firestore/cloud_firestore.dart';

class YGBasvuru {
  final String id,
      kullaniciId,
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
      yerlestirmePt,
      bfakulte,
      bbolum,
      bogretimTuru;
  final int not, ydPuani;
  final DateTime dt, yerlesmeYili;

  YGBasvuru(
      {this.id,
      this.kullaniciId,
      this.basvuruTuru,
      this.adSoyad,
      this.tc,
      this.adres,
      this.gsm,
      this.tel,
      this.mail,
      this.universite,
      this.fakulte,
      this.bolum,
      this.sinif,
      this.disiplinCezasi,
      this.ogretimTuru,
      this.no,
      this.yerlesmeYili,
      this.yerlestirmePt,
      this.not,
      this.ydPuani,
      this.dt,
      this.bfakulte,
      this.bbolum,
      this.bogretimTuru});

  factory YGBasvuru.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return YGBasvuru(
      id: doc.id,
      kullaniciId: docData['kullaniciId'],
      basvuruTuru: docData['basvuruTuru'],
      adSoyad: docData['adSoyad'],
      tc: docData['tc'],
      adres: docData['adres'],
      gsm: docData['gsm'],
      tel: docData['tel'],
      mail: docData['mail'],
      universite: docData['universite'],
      fakulte: docData['fakulte'],
      bolum: docData['bolum'],
      sinif: docData['sinif'],
      disiplinCezasi: docData['disiplinCezasi'],
      ogretimTuru: docData['ogretimTuru'],
      no: docData['no'],
      yerlesmeYili: docData['yerlesmeYili'],
      yerlestirmePt: docData['yerlestirmePt'],
      not: docData['not'],
      ydPuani: docData['ydPuani'],
      dt: docData['dt'],
      bfakulte: docData['basvurulanFakulte'],
      bbolum: docData['basvurulanBolum'],
      bogretimTuru: docData['basvurulanOgretimTuru'],
    );
  }
}
