import 'dart:async';

import 'package:brow/model/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

class Wait extends StatefulWidget {
  final Order order;

  Wait({Key key, this.order}) : super(key: key);

  @override
  _WaitState createState() => _WaitState(order);
}

class _WaitState extends State<Wait> {
  Order order;
  String status = "Arguardando resposta";

  _WaitState(this.order);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(order.amountBrownie);

    Duration duration = Duration(seconds: 3);

    Future.delayed(duration).then((_) {
      setState(() {
        status = "confirmação realizada";
      });
      Future.delayed(duration).then(
        (_) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              order: order,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildLoading(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("Brow Delivery"),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 20.0,
          ),
          Text("Status: $status"),
        ],
      ),
    );
  }
}
