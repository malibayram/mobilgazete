import 'package:flutter/material.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Indirimlerim extends StatelessWidget {
  final User user;

  Indirimlerim({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İndirimlerim"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('images/bimlogo.png'),
                    ),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset('images/indirimon.png'),
                    ),
                    subtitle: Text("25 - 31 Mayıs 2020"),
                    title: Text(
                      "Bim",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ListTile(
                    subtitle: Text("Haziran ayı boyunca geçerlidir."),
                    leading: Image(
                      image: AssetImage('images/petrolofisilogo.png'),
                    ),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset('images/indirimyirmi.png'),
                    ),
                    title: Text(
                      "Petrol Ofisi",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
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
