import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase{

  String userID = "531431548315";

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID: userID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2), () => User(userID: userID));
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) {
    // TODO: implement createUserWithEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) {
    // TODO: implement signInWithEmailandPassword
    throw UnimplementedError();
  }

  signInWithCredential(AuthCredential credential) {

  }

}