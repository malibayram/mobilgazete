import 'package:flutter/material.dart';
import 'package:mobilturkiyem/model/user_model.dart';
import 'package:mobilturkiyem/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class Egazete extends StatelessWidget {
  final User user;

  Egazete({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Gazete"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.arrow_back_ios),
                Image(
                  image: NetworkImage('https://i.gazeteoku.com/storage/files/images/2020/05/27/turkiye-gazetesi-2020-05-27-Onjg.jpg'),
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
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
