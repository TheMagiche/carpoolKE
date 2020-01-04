import 'package:flutter/material.dart';

class DriverComponent extends StatefulWidget {
  @override
  _DriverComponentState createState() => _DriverComponentState();
}

class _DriverComponentState extends State<DriverComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text('Driver page'),
    ));
  }
}
