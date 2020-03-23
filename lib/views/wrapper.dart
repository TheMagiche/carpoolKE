import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/views/authenticate/authenticate.dart';
import 'package:carpoolke/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Home(user: user);
    } else {
      return Authenticate();
    }
  }
}
