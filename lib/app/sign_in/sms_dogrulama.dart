// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilturkiyem/app/sign_in/sms_dogrulama.dart';
import 'package:mobilturkiyem/common_widget/social_log_in_button.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SmsDogrulama extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => SmsDogrulamaState();
}

class SmsDogrulamaState extends State<SmsDogrulama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Benim Türkiyem"),
        elevation: 0,
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _PhoneSignInSection(Scaffold.of(context)),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }
}

class _PhoneSignInSection extends StatefulWidget {
  _PhoneSignInSection(this._scaffold);

  final ScaffoldState _scaffold;
  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState();
}

class _PhoneSignInSectionState extends State<_PhoneSignInSection> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId; //hocam bu arada orjinalinde bu değişkenlerin yari farklıydı galiba

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _smsController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: "Sms ile gelen 6 haneli kodu giriniz.",
              labelText: "Doğrulama Kodu",
              border: OutlineInputBorder(),
            ),
          ),
          Container(//uhhhh hele şükür
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
    );
  }

  // Example code of how to verify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      debugPrint("compleyed calıstı gelen credential $phoneAuthCredential");
      setState(() {//kod gönderiyordum
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      widget._scaffold.showSnackBar(const SnackBar(
        content: Text('Please check your phone for the verification code.'),
      ));
      debugPrint("codesnt calıstı gelen verificationId $verificationId");
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
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
    final _userModel = Provider.of<UserModel>(context,listen: false);
    User myUser = await _userModel.signInWithCredential(credential);
    debugPrint("gelen user:"+myUser.userID);
  }
}