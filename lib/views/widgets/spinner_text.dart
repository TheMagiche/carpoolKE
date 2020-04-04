import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget {
  final String text;

  const SpinnerText({Key key, this.text}) : super(key: key);

  @override
  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = '';
  String bottomText = '';

  AnimationController _spinTextAnimationController;
  Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;

    _spinTextAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() => setState(() {}))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                bottomText = topText;
                topText = '';
                _spinTextAnimationController.value = 0;
              });
            }
          });

    _spinAnimation = CurvedAnimation(
        parent: _spinTextAnimationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      //Need to spin the old text
      topText = widget.text;
      //run animation
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value - 1.0),
            child: new Text(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.brown, fontSize: 14.0, fontFamily: 'Oxygen'),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value),
            child: new Text(
              bottomText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.brown, fontSize: 14.0, fontFamily: 'Oxygen'),
            ),
          )
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
