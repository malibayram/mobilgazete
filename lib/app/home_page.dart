import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilturkiyem/app/egazete.dart';
import 'package:mobilturkiyem/app/gazetemle_gelsin.dart';
import 'package:mobilturkiyem/app/indirimlerim.dart';
import 'package:mobilturkiyem/locator.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/services/auth_base.dart';
import 'package:mobilturkiyem/services/firebase_auth_service.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () => _cikisYap(context),
            child: Icon(Icons.power_settings_new, color: Colors.white, size: 25,),
          )
        ],
        title: Text("Ana Sayfa"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Egazete())),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset('images/egazetelogo.jpg'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "E-Gazete",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>GazetemleGelsin())),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset('images/dagitici.jpg'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "Gazetemle Gelsin",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Indirimlerim())),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset('images/indirim.png'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "İndirimlerim",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }
}
