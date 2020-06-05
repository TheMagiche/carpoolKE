import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/shared/constants.dart';
import 'package:carpoolke/views/shared/main_btn.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/views/widgets/loading.dart';
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
  String fname = '';
  String lname = '';
  String email = '';
  String error = '';
  String nationalID = '';
  String phoneNumber = '';
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
        dynamic result = await _auth.registerWithEmailAndPassword(
            email, password, fname, lname, nationalID, phoneNumber);
        if (result == null) {
          setState(() {
            error = 'Please supply valid credentials';
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
                                      height: 250,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: TextFormField(
                                                  decoration:
                                                      formTextInputDecoration
                                                          .copyWith(
                                                    labelText: 'First Name',
                                                    suffixIcon: Icon(
                                                      Icons.accessibility,
                                                      color: Colors.brown,
                                                      size: formIconSize,
                                                    ),
                                                  ),
                                                  validator: (val) =>
                                                      val.isEmpty
                                                          ? 'Enter first name'
                                                          : null,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      fname = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  decoration:
                                                      formTextInputDecoration
                                                          .copyWith(
                                                    labelText: 'Last Name',
                                                    suffixIcon: Icon(
                                                      Icons.accessibility,
                                                      color: Colors.brown,
                                                      size: formIconSize,
                                                    ),
                                                  ),
                                                  validator: (val) =>
                                                      val.isEmpty
                                                          ? 'Enter last name'
                                                          : null,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      lname = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Expanded(
                                                child: TextFormField(
                                                  decoration:
                                                      formTextInputDecoration
                                                          .copyWith(
                                                    labelText: 'National ID',
                                                    suffixIcon: Icon(
                                                      Icons.account_box,
                                                      color: Colors.brown,
                                                      size: formIconSize,
                                                    ),
                                                  ),
                                                  validator: (val) => val
                                                          .isEmpty
                                                      ? 'Enter your national ID number'
                                                      : null,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      nationalID = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  decoration:
                                                      formTextInputDecoration
                                                          .copyWith(
                                                    labelText: 'Phone Number',
                                                    suffixIcon: Icon(
                                                      Icons.phone,
                                                      color: Colors.brown,
                                                      size: formIconSize,
                                                    ),
                                                  ),
                                                  validator: (val) =>
                                                      val.isEmpty
                                                          ? 'Enter phone number'
                                                          : null,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      phoneNumber = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
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
                                    Padding(padding: EdgeInsets.all(2.0)),
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
                                              'Already a member?',
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
                                            text: 'Register',
                                            myFunc:
                                                _registerWithEmailAndPassword,
                                            myicon:
                                                Icon(Icons.arrow_forward_ios)),
                                      ),
                                    ),
                                    Container(
                                      height: 15.0,
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
                                screenText: 'Register',
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
