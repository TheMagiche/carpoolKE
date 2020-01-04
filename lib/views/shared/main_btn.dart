import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function myFunc;
  final Icon myicon;

  const MainButton({Key key, this.text, this.myFunc, this.myicon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.red)),
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          onPressed: myFunc,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontFamily: 'Oxygen'),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16.0,
                    )),
              ],
            ),
          )),
    );
  }
}
