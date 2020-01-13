import 'package:brow/ui/screen_admin/orders.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildList(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Brow Delivery"),
    );
  }

  Widget buildList() {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text('Pedidos feitos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (build) => Orders(
                    typeScreen: "PEDIDOS_FEITOS",
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Pedidos autorizados'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (build) => Orders(
                    typeScreen: "PEDIDOS_AUTORIZADOS",
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Pedidos cancelados'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (build) => Orders(
                    typeScreen: "PEDIDOS_CANCELADOS",
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Pedidos concluídos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (build) => Orders(
                    typeScreen: "PEDIDOS_CONCLUIDOS",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
