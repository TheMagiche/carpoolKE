import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/shared/constants.dart';
import 'package:carpoolke/views/shared/main_btn.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:carpoolke/views/widgets/socialbuttons.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({
    Key key,
    this.toggleView,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  bool isloading = false;
  String email = '';
  String error = '';
  String password = '';
  Function _registerWithEmailAndPassword;

  @override
  void initState() {
    super.initState();
    _registerWithEmailAndPassword = () async {
      if (_formKey.currentState.validate()) {
        setState(() {
          isloading = true;
        });
        dynamic result =
            await _auth.registerWithEmailAndPassword(email, password);
        if (result == null) {
          setState(() {
            error = 'Please supply a valid email';
          });
          setState(() {
            isloading = false;
          });
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.dstATop),
                                image: AssetImage('assets/main-bg.png'),
                              )),
                        )),
                    Expanded(
                      flex: 5,
                      child: Card(
                        margin: EdgeInsets.all(0.0),
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        color: Colors.red,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                TextFormField(
                                  decoration: formTextInputDecoration.copyWith(
                                    labelText: 'email',
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                      size: formIconSize,
                                    ),
                                  ),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                TextFormField(
                                  decoration: formTextInputDecoration.copyWith(
                                    labelText: 'password',
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: formIconSize,
                                    ),
                                  ),
                                  validator: (val) => val.length < 6
                                      ? 'Enter a password six characters long'
                                      : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(error,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0)),
                                Expanded(
                                  child: Container(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Already a member?',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Oxygen',
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      onPressed: widget.toggleView,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SocialButton(
                                  image: 'assets/logos_facebook.png',
                                  text: 'FACEBOOK',
                                ),
                                SocialButton(
                                  image: 'assets/logos_google-icon.png',
                                  text: 'GOOGLE  ',
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Center(
                              child: MainButton(
                                  text: 'Register',
                                  myFunc: _registerWithEmailAndPassword,
                                  myicon: Icon(Icons.arrow_forward_ios)),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: CarpoolAppBar(
                    screenText: 'Register',
                  ),
                ),
              ],
            ),
          );
  }
}
