import 'package:flutter/material.dart';
import 'dart:math';

class GazetemleGelsin extends StatefulWidget {
  @override
  _GazetemleGelsinState createState() => _GazetemleGelsinState();
}

class _GazetemleGelsinState extends State<GazetemleGelsin> {
  String dersAdi;
  List<Ders> tumDersler;
  static int sayac = 0;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Gazetemle Gelsin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return uygulamaGovdesi();
        } else {
          return uygulamaGovdesiLandscape();
        }
      }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //STATIC FORMU TUTAN CONTAINER
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Talep",
                      hintText: "Lütfen talebinizi buraya yazınız.",
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 22),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade200, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade200, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Colors.purple, width: 2)),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else {
                        return "Talep kısmını boş bıraktınız.";
                      }
                    },
                    onSaved: (kaydedilecekDeger) {
                      dersAdi = kaydedilecekDeger;
                      setState(() {
                        tumDersler.add(Ders(dersAdi, rastgeleRenkOlustur()));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          //DINAMIK LISTEYI TUTAN CONTAINER
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //color: Colors.pink.shade200,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Talep",
                              hintText: "Lütfen talebinizi buraya yazınız.",
                              hintStyle: TextStyle(fontSize: 18),
                              labelStyle: TextStyle(fontSize: 22),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2)),
                            ),
                            validator: (girilenDeger) {
                              if (girilenDeger.length > 0) {
                                return null;
                              } else {
                                return "Talep kısmını boş bıraktınız.";
                              }
                            },
                            onSaved: (kaydedilecekDeger) {
                              dersAdi = kaydedilecekDeger;
                              setState(() {
                                tumDersler.add(Ders(dersAdi,rastgeleRenkOlustur()));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 1),
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: tumDersler[index].renk, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(Icons.done, size: 36, color: tumDersler[index].renk),
          title: Text(tumDersler[index].ad),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: tumDersler[index].renk),
        ),
      ),
    );
  }

  Color rastgeleRenkOlustur() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Ders {
  String ad;
  Color renk;

  Ders(this.ad, this.renk);
}