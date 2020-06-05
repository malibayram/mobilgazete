import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilturkiyem/common_widget/social_log_in_button.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum FormType { Register, logIn }

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _tel, _sifre;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context);
    _tel = "+90" + _tel;
    debugPrint("Telefon : " + _tel + " Şifre : " + _sifre);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _phoneNumberController = TextEditingController();
    final TextEditingController _smsController = TextEditingController();

    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mobil Türkiyem"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: _userModel.state == ViewState.Idle ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Telefon numaranızı başında sıfır olmadan 10 haneli olarak giriniz.",
                    labelText: "Telefon",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilentelefon) {
                    _tel = girilentelefon.trim();
                  },
                ),
                SizedBox(height: 8.0,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Şifre",
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilenSifre) {
                    _sifre = girilenSifre;
                  },
                ),
                SizedBox(height: 8.0,),
                SocialLogInButton(
                  butonText: "Giriş",
                  butonColor: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () => _formSubmit(),
                  radius: 10,
                ),
                SocialLogInButton(
                  butonText: "Deneme Sayfası",
                  butonColor: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () => Navigator.pushNamed(context, "/signin_page"),
                  radius: 10,
                ),
              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
