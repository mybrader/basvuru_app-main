import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basvuru_app/models/users.dart';
import 'package:basvuru_app/services/authenticationservice.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime zaman = DateTime.now();

  Future<void> kullaniciOlustur({id, email, kullaniciAdi, fotoUrl = ""}) async {
    await _firestore.collection("kullanicilar").doc(id).set({
      "kullaniciAdi": kullaniciAdi,
      "email": email,
      "fotoUrl": fotoUrl,
      "hakkinda": "",
      "olusturulmaZamani": zaman
    });
  }

  Future<Kullanici> kullaniciGetir(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("kullanicilar").doc(id).get();
    if (doc.exists) {
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
    return null;
  }

  void kullaniciGuncelle(
      {String kullaniciId,
      String kullaniciAdi,
      String fotoUrl = "",
      String hakkinda}) {
    _firestore.collection("kullanicilar").doc(kullaniciId).update({
      "kullaniciAdi": kullaniciAdi,
      "hakkinda": hakkinda,
      "fotoUrl": fotoUrl
    });
  }

  Future<List<Kullanici>> kullaniciAra(String kelime) async {
    QuerySnapshot snapshot = await _firestore
        .collection("kullanicilar")
        .where("kullaniciAdi",
            isGreaterThanOrEqualTo: kelime) //parametre değerini içerenler
        .get();

    List<Kullanici> kullanicilar =
        snapshot.docs.map((doc) => Kullanici.dokumandanUret(doc)).toList();
    return kullanicilar;
  }

  Future<void> ygBasvuru(
      {kullaniciId,
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
      not,
      ydPuani,
      dt,
      bfakulte,
      bbolum,
      bogretimTuru}) async {
    await _firestore
        .collection("basvurular")
        .doc(kullaniciId)
        .collection("kullaniciBasvurulari")
        .add({
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
    });
  }
}
