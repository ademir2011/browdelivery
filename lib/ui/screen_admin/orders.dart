import 'package:brow/helpers/status_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Orders extends StatefulWidget {
  String typeScreen;

  Orders({this.typeScreen});

  @override
  _OrdersState createState() => _OrdersState(typeScreen);
}

class _OrdersState extends State<Orders> {
  String typeScreen;

  _OrdersState(this.typeScreen);

  String typeScreenName(String typeScreen) {
    return typeScreen == "PEDIDOS_FEITOS"
        ? 'Feitos'
        : typeScreen == "PEDIDOS_AUTORIZADOS"
            ? 'Autorizados'
            : typeScreen == "PEDIDOS_CANCELADOS"
                ? 'Cancelados'
                : typeScreen == "PEDIDOS_CONCLUIDOS" ? 'Concluídos' : null;
  }

  String typeScreenCutName(String typeScreen) {
    return typeScreen == "PEDIDOS_FEITOS"
        ? 'FEITO'
        : typeScreen == "PEDIDOS_AUTORIZADOS"
            ? 'AUTORIZADO'
            : typeScreen == "PEDIDOS_CANCELADOS"
                ? 'CANCELADO'
                : typeScreen == "PEDIDOS_CONCLUIDOS" ? 'CONCLUIDO' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'Pedidos ' + typeScreenName(typeScreen),
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
      stream: Firestore.instance
          .collection('orders')
          .where("orderStatus", isEqualTo: typeScreenCutName(typeScreen))
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Nenhum dado!');

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data.documents[index];

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
                          onPressed: () {
                            Firestore.instance
                                .collection('orders')
                                .document(doc.documentID)
                                .updateData({'orderStatus': 'AUTORIZADO'});
                          },
                        ),
                        RaisedButton(
                          child: Icon(FontAwesomeIcons.times),
                          onPressed: () {
                            Firestore.instance
                                .collection('orders')
                                .document(doc.documentID)
                                .updateData({'orderStatus': 'CANCELADO'});
                          },
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
