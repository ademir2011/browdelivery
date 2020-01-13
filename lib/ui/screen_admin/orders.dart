import 'package:brow/helpers/status_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'Pedidos x',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: buildList(),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Brow Delivery"),
    );
  }

  Widget buildList() {
    return StreamBuilder(
      stream: Firestore.instance.collection('orders').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Nenhum dado!');

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data.documents[index];
            print(doc['tod'].toDate());
            var date = doc['tod'].toDate();

            return Card(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Quantidade: ${doc['amountBrownie']}'),
                        Text('Localização:${doc['location']}'),
                        Text('Nome:${doc['userName']}'),
                        Text('Horário de chegada:${date.hour}:${date.minute}'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton(
                          child: Icon(FontAwesomeIcons.check),
                          onPressed: () {},
                        ),
                        RaisedButton(
                          child: Icon(FontAwesomeIcons.times),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
