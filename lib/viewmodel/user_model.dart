import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilturkiyem/locator.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/repository/user_repository.dart';
import 'package:mobilturkiyem/services/auth_base.dart';

enum ViewState {Idle, Busy}

class UserModel with ChangeNotifier implements AuthBase{

  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;

  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel(){
    currentUser();
  }//hocam bilmiyorum son zamanlarda bir değişiklik yaptım mı ama bu kodlarla ben maille giriş yapıyordum yönlendirme sorunu yaşayamıyordum
  // yaptığınızı anladım ama neden o zaman sorun yaşamıyordum onu anlamadım, bi sorun olmaz zatn de yine de dogrusu bu

  @override
  Future<User> currentUser() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki currentUserda hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signOut hata : " + e.toString());
      return false;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signInAnonymouslyda hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signInWithGoogle hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInWithFacebook();
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signInWithFacebook hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.createUserWithEmailandPassword(email, sifre);
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki createUserWithEmailandPassword hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInWithEmailandPassword(email, sifre);
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signInWithEmailandPassword hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  Future<User> signInWithCredential(AuthCredential credential) async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInWithCredential(credential);
      debugPrint("burada 1 user getirildi"+_user.toString());
      return _user;
    }catch(e){
      debugPrint("Viewmodel/user_model.dart taki signInWithCredential hata : " + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }
}