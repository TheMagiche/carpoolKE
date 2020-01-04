import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String image;
  final String text;

  const SocialButton({Key key, this.image, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Container(
                child: Image(
                  image: AssetImage(image),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Container(
                child: Center(
                  child: Text(text),
                ),
              ),
            )
          ],
        ));
  }
}
