import 'package:flutter/material.dart';

class WalletComponent extends StatefulWidget {
  @override
  _WalletComponentState createState() => _WalletComponentState();
}

class _WalletComponentState extends State<WalletComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text('Wallet page'),
    ));
  }
}
