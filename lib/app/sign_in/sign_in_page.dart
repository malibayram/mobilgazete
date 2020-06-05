// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilturkiyem/app/abonelik_formu.dart';
import 'package:mobilturkiyem/common_widget/social_log_in_button.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId; //hocam bu arada orjinalinde bu değişkenlerin yari farklıydı galiba
  String sayfaGorunum = "telefon";
  var myController = PageController(
      initialPage: 0, keepPage: true, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Benim Türkiyem"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              sayfaGorunum == "telefon" ?
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Abone Girişi",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Başında sıfır olmadan 10 haneli olarak",
                        labelText: "Telefon",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return '+x xxx-xxx-xxxx';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: SocialLogInButton(
                        butonText: "Kod Gönder",
                        butonColor: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () async {
                          _verifyPhoneNumber();
                          sayfaGorunum = "kod";
                        },
                        radius: 10,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: SocialLogInButton(
                        butonText: "Abone Olmak İstiyorum",
                        butonColor: Colors.orange,
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AbonelikFormu()));
                        },
                        radius: 10,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        reverse: false,
                        controller: myController,
                        pageSnapping: true,
                        //en ufak bir hareketle yana geçsin mi sürüklediği kadarıyla kalsın mı
                        onPageChanged: (index) {},
                        //hangi sayfaya geçtiysen onun indexini verir
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            color: Colors.yellow.shade200,
                            child: Center(
                              child: Text(
                                "Buraya",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.yellow.shade400,
                            child: Center(
                              child: Text(
                                "Tanıtım",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.yellow.shade600,
                            child: Center(
                              child: Text(
                                "Görselleri",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.yellow.shade800,
                            child: Center(
                              child: Text(
                                "Koyabiliriz.",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  :
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Kodu Giriniz",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _smsController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Sms ile gelen 6 haneli kodu giriniz.",
                        labelText: "Doğrulama Kodu",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container( //uhhhh hele şükür
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: SocialLogInButton(
                        butonText: "Giriş",
                        butonColor: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () async {
                          _signInWithPhoneNumber();
                        },
                        radius: 10,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _message,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }

  // Example code of how to verify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      debugPrint("compleyed calıstı gelen credential $phoneAuthCredential");
      setState(() {
        //_message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
        //'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
        'Lütfen telefon numaranızı başında sıfır olmadan 10 haneli ve boşluksuz olarak giriniz.';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      debugPrint("codesnt calıstı gelen verificationId $verificationId");
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    String _telefonNo = _phoneNumberController.text;

    List _telefonNoArray = _telefonNo.split('');

    String _yeniTelefonNo = "+90 " + _telefonNoArray[0] +
        _telefonNoArray[1] + _telefonNoArray[2] + "-" + _telefonNoArray[3] +
        _telefonNoArray[4] + _telefonNoArray[5] + "-" + _telefonNoArray[6] +
        _telefonNoArray[7] + _telefonNoArray[8] + _telefonNoArray[9];

        await
    _auth.verifyPhoneNumber(
        phoneNumber: _yeniTelefonNo,
        timeout: const Duration(seconds: 55),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }


  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final _userModel = Provider.of<UserModel>(context, listen: false);
    User myUser = await _userModel.signInWithCredential(credential);
    debugPrint("gelen user:" + myUser.userID);
  }
}