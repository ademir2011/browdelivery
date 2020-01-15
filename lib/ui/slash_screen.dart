import 'package:brow/ui/autentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Duration duration = Duration(seconds: 3);
    Future.delayed(duration).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Autentication(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.storeAlt,
            size: 80.0,
            color: Colors.brown,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Brow Delivery",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.brown,
              decoration: TextDecoration.none,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
