import 'package:firebase_auth/firebase_auth.dart';
import 'package:basvuru_app/models/users.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String aktifKullaniciId;

  Kullanici _kullaniciOlustur(User kullanici) {
    return kullanici == null ? null : Kullanici.firebasedenUret(kullanici);
  }

  Stream<Kullanici> get durumTakipcisi {
    return _firebaseAuth.authStateChanges().map(_kullaniciOlustur);
  }

  Future<Kullanici> mailIleKayit(String eposta, String sifre) async {
    var girisKarti = await _firebaseAuth.createUserWithEmailAndPassword(
        email: eposta, password: sifre);
    return _kullaniciOlustur(girisKarti.user);
  }

  Future<Kullanici> mailIleGiris(String eposta, String sifre) async {
    var girisKarti = await _firebaseAuth.signInWithEmailAndPassword(
        email: eposta, password: sifre);
    return _kullaniciOlustur(girisKarti.user);
  }

  Future<void> cikisYap() {
    return _firebaseAuth.signOut();
  }

  Future<void> sifremiSifirla(String eposta) async {
    await _firebaseAuth.sendPasswordResetEmail(email: eposta);
  }
}