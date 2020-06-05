import 'package:flutter/cupertino.dart';

class User{
  final String userID;
  String telefon;
  DateTime createdAt;

  User({@required this.userID, @required this.telefon});

  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'telefon' : telefon,
      'createdAt' : createdAt ?? '',
    };
  }
}