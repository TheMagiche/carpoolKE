import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/shared/constants.dart';
import 'package:carpoolke/views/shared/main_btn.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/views/widgets/loading.dart';

// import 'package:carpoolke/views/widgets/socialbuttons.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({
    Key key,
    this.toggleView,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  String email = '';
  String error = '';
  String password = '';
  Function _signInWithEmailAndPassword;

  @override
  void initState() {
    super.initState();
    _signInWithEmailAndPassword = () async {
      if (_formKey.currentState.validate()) {
        setState(() {
          isloading = true;
        });
        dynamic result =
            await _auth.signInWithEmailAndPassword(email, password);
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
        : Container(
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: true,
              body: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 350,
                                      decoration: BoxDecoration(
                                        backgroundBlendMode:
                                            BlendMode.colorDodge,
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/children.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: Center(
                                      child: Text(
                                        'LET\'S START A REVOLUTION',
                                        style: TextStyle(
                                          color: Colors.brown,
                                          fontFamily: 'bradhitc',
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    )),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            decoration: formTextInputDecoration
                                                .copyWith(
                                              labelText: 'Email',
                                              suffixIcon: Icon(
                                                Icons.email,
                                                color: Colors.brown,
                                                size: formIconSize,
                                              ),
                                            ),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter an email'
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                email = val;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            decoration: formTextInputDecoration
                                                .copyWith(
                                              labelText: 'Password',
                                              suffixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.brown,
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
                                          Text(error,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 50.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'Need an account?',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'bradhitc',
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            onPressed: widget.toggleView,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: MainButton(
                                            text: 'Login',
                                            myFunc: _signInWithEmailAndPassword,
                                            myicon:
                                                Icon(Icons.arrow_forward_ios)),
                                      ),
                                    ),
                                    Container(
                                      height: 25.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: CarpoolAppBar(
                                screenText: 'Login',
                                bgColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
