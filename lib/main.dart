import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authservice().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CarPoolKe',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Wrapper(),
      ),
    );
  }
}
