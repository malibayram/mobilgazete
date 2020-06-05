import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilturkiyem/locator.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/services/auth_base.dart';
import 'package:mobilturkiyem/services/fake_auth_service.dart';
import 'package:mobilturkiyem/services/firebase_auth_service.dart';
import 'package:mobilturkiyem/services/firestore_db_service.dart';

enum AppMode {DEBUG, RELEASE}

class UserRepository implements AuthBase{

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService = locator<FakeAuthenticationService>();
  FirestoreDbService _firestoreDbService = locator<FirestoreDbService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> currentUser() async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.currentUser();
    }else{
      return await _firebaseAuthService.currentUser();
    }
  }

  @override
  Future<bool> signOut() async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signOut();
    }else{
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User> signInAnonymously() async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInAnonymously();
    }else{
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithGoogle();
    }else{
      return await _firebaseAuthService.signInWithGoogle();
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithFacebook();
    }else{
      return await _firebaseAuthService.signInWithFacebook();
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.createUserWithEmailandPassword(email, sifre);
    }else{
      return await _firebaseAuthService.createUserWithEmailandPassword(email, sifre);
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithEmailandPassword(email, sifre);
    }else{
      return await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
    }
  }

  Future<User> signInWithCredential(AuthCredential credential) async {
    if(appMode == AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithCredential(credential);
    }else{
      User _user = await _firebaseAuthService.signInWithCredential(credential);
      bool _sonuc = await _firestoreDbService.saveUser(_user);
      if(_sonuc){
        return _user;
      }else return null;
    }
  }
}