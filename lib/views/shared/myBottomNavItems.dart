import 'package:flutter/material.dart';

class MyBottomNavItems extends StatelessWidget {
  final IconData myBtnIcon;
  final String myBtnString;

  const MyBottomNavItems({Key key, this.myBtnIcon, this.myBtnString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            myBtnIcon,
            size: 20,
            color: Colors.white,
          ),
          Text(
            myBtnString,
            style: TextStyle(
              fontFamily: 'Oxygen',
              fontSize: 10.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
