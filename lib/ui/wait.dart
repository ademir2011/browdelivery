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
  var ordersWaiting = [
    Order(
        amountBrownie: 4,
        location: "Sala A321",
        orderAproved: false,
        tod: TimeOfDay.now()),
    Order(
        amountBrownie: 2,
        location: "Sala B201",
        orderAproved: false,
        tod: TimeOfDay.now())
  ];

  var ordersAccepted = [];
  var ordersRecused = [];
  var ordersFinished = [];

  _WaitState(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: buildAccept(),
      ),
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

  Widget buildAccept() {
    return Column(
      children: <Widget>[
        Text('Pedidos pendentes'),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ordersWaiting.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(FontAwesomeIcons.bars),
                      title: Text('Nome: Fulana de Tal'),
                      subtitle: Text(
                        'Local de Entrega: ${ordersWaiting[index].location}\nQuantidade:${ordersWaiting[index].amountBrownie}\nHora da Entrega: ${ordersWaiting[index].tod.hour}:${ordersWaiting[index].tod.minute}',
                      ),
                    ),
                    Divider(
                      height: 3,
                      thickness: 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('RECUSAR'),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        RaisedButton(
                          child: Text('ACEITAR'),
                          onPressed: () {
                            if (order != null) {
                              setState(() {
                                ordersWaiting.removeAt(index);
                                order.orderAproved = true;
                                ordersAccepted.add(order);
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text('Pedidos Autorizados'),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ordersAccepted.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(FontAwesomeIcons.bars),
                      title: Text('Nome: Fulana de Tal'),
                      subtitle: Text(
                        'Local de Entrega: ${ordersAccepted[index].location}\nQuantidade:${ordersAccepted[index].amountBrownie}\nHora da Entrega: ${ordersAccepted[index].tod.hour}:${ordersAccepted[index].tod.minute}',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
