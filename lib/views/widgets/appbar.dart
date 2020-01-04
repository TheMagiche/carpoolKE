import 'package:carpoolke/views/widgets/spinner_text.dart';
import 'package:flutter/material.dart';

class CarpoolAppBar extends StatelessWidget {
  final String screenText;

  CarpoolAppBar({Key key, this.screenText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String mainScreenText = 'CarPoolKE KIDS EDITION';
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SpinnerText(
            text: screenText,
          ),
          Text(
            '$mainScreenText',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Oxygen',
            ),
          )
        ],
      ),
    );
  }
}
