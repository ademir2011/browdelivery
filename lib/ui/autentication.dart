import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Autentication extends StatefulWidget {
  @override
  _AutenticationState createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {
  final _formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildLogin(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Brow Delivery"),
    );
  }

  Widget buildLogin() {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.shoppingCart,
                size: 60.0,
                color: Colors.brown,
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.user),
                  labelText: "Login",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.lock),
                  labelText: "Senha",
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.check),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text("Logar"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.google),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text("Logar com conta Google"),
                        ],
                      ),
                      onPressed: () {
                        logar();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logar() {
    _googleSignIn.signIn().then((data) {
      print('Usuário ${data.displayName} autenticado!');
    }).catchError((err) => print(err));
  }
}
