import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/services/auth_base.dart';

class FirebaseAuthService implements AuthBase{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try{
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    }catch(e){
      print("firebase_auth_service.dart dosyasında currentUser()da hata " + e.toString());
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if(user == null)
      return null;
    else{
      return User(userID: user.uid, telefon: user.phoneNumber);
    }

  }

  @override
  Future<bool> signOut() async {
    try{
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      final _facebookLogin = FacebookLogin();
      await _facebookLogin.logOut();
      await _firebaseAuth.signOut();
      return true;
    }catch(e){
      print("firebase_auth_service.dart dosyasında signOut()da hata : " + e.toString());
      return false;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try{
      AuthResult sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    }catch(e){
      print("firebase_auth_service.dart dosyasında signInAnonymously()da hata : " + e.toString());
      return null;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    if(_googleUser != null){
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if(_googleAuth.idToken != null && _googleAuth.accessToken != null){
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken)
        );
        FirebaseUser _user = sonuc.user;
        return _userFromFirebase(_user);
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final _facebookLogin = FacebookLogin();
    FacebookLoginResult _faceResult = await _facebookLogin.logInWithReadPermissions(['public_profile','email']);
    switch(_faceResult.status){
      case FacebookLoginStatus.loggedIn:
        if(_faceResult.accessToken != null){
          AuthResult _firebaseResult = await _firebaseAuth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: _faceResult.accessToken.token));
          FirebaseUser _user = _firebaseResult.user;
          return _userFromFirebase(_user);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Kullanıcı facebook girişi iptal etti.");
        break;
      case FacebookLoginStatus.error:
        print("Facebook login hatası : " + _faceResult.errorMessage);
        break;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async {
    try{
      AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    }catch(e){
      print("firebase_auth_service.dart dosyasında createUserWithEmailandPassword()da hata : " + e.toString());
      return null;
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    try{
      AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    }catch(e){
      print("firebase_auth_service.dart dosyasında signInWithEmailandPassword()da hata : " + e.toString());
      return null;
    }
  }


  signInWithCredential(AuthCredential credential) async {
    try{

      AuthResult sonuc = await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser _user = sonuc.user;
      debugPrint("burada 2 user:"+_user.uid);
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(_user.uid == currentUser.uid);
      return _userFromFirebase(_user);
    }catch(e){
      print("firebase_auth_service.dart dosyasında signInWithCredential()da hata : " + e.toString());
      return null;
    }
  }
}