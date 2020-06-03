import 'package:carpoolke/views/widgets/spinner_text.dart';
import 'package:flutter/material.dart';

class AltCarpoolAppBar extends StatelessWidget {
  final String screenText;
  final Color bgColor;
  final TabBar tabBar;

  AltCarpoolAppBar({
    Key key,
    this.screenText,
    this.bgColor,
    this.tabBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String mainScreenText = 'CarPoolKE KIDS EDITION';
    return AppBar(
      elevation: 0.0,
      backgroundColor: bgColor,
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
              color: Colors.red,
              fontSize: 20.0,
              fontFamily: 'bradhitc',
            ),
          )
        ],
      ),
      bottom: tabBar,
    );
  }
}
