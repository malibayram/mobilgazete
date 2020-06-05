import 'package:flutter/material.dart';
import 'package:mobilturkiyem/app/abonelik_formu.dart';
import 'package:mobilturkiyem/app/home_page.dart';
import 'package:mobilturkiyem/app/indirimlerim.dart';
import 'package:mobilturkiyem/app/landing_page.dart';
import 'package:mobilturkiyem/app/sign_in/sign_in_page.dart';
import 'package:mobilturkiyem/app/sign_in/sms_dogrulama.dart';
import 'package:mobilturkiyem/locator.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserModel(),
      child: MaterialApp(
        title: 'Benim Türkiyem',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: "anaSayfa",
        routes: {
          "/" : (context) => LandingPage(),
          "/anaSayfa" : (context) => LandingPage(),
          "/indirimlerim" : (context) => Indirimlerim(),
          "/sign_in_page" : (context) => SignInPage(),
          "/abonelik_formu" : (context) => AbonelikFormu(),
        },
      ),
    );
  }
}


