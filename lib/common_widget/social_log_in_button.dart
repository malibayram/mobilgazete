import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialLogInButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const SocialLogInButton(
      {Key key,
      @required this.butonText,
      this.butonColor: Colors.purple,
      this.textColor: Colors.white,
      this.radius: 16,
      this.yukseklik: 40,
      this.butonIcon,
      this.onPressed})
      : assert(butonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if(butonIcon != null)...[
                butonIcon,
                Text(
                  butonText,
                  style: TextStyle(color: textColor),
                ),
                Opacity(child: butonIcon, opacity: 0,),
              ],
              if(butonIcon == null)...[
                Container(),
                Text(
                  butonText,
                  style: TextStyle(color: textColor),
                ),
                Container(),
              ]
            ],
          ),
          color: butonColor,
        ),
      ),
    );
  }
}
