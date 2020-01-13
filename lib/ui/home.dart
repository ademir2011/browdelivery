import 'package:brow/model/order.dart';
import 'package:brow/ui/autentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:brow/ui/cart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  final Order order;
  final GoogleSignInAccount gData;
  final GoogleSignIn googleSignIn;

  Home({Key key, this.order, this.gData, this.googleSignIn}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(order, gData, googleSignIn);
}

class _HomeState extends State<Home> {
  Order order;
  GoogleSignInAccount gData;
  GoogleSignIn _googleSignIn;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool orderFinished = false;

  _HomeState(this.order, this.gData, this._googleSignIn);

  // CollectionReference orderReference =
  //     Firestore.instance.collection('Orders').reference();

  Widget fbt() {
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('carregando...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              print(ds['nome']);
              return ListTile(
                title: Text(ds['nome']),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          fbt(),
          Text(!orderFinished ? "" : "Pedido enviado!"),
          buildCardWaiting(),
          buildCardSection(),
          Expanded(
            child: buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
        },
        child: Icon(
          FontAwesomeIcons.cartPlus,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Brow Delivery"),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.times),
            onPressed: () {
              _googleSignIn.signOut();
              Navigator.pushReplacement(
                this.context,
                MaterialPageRoute(
                  builder: (context) => Autentication(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(
        10.0,
      ),
      itemCount: 10,
      itemBuilder: (context, i) {
        return getRow(i);
      },
    );
  }

  Widget getRow(i) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            FontAwesomeIcons.cheese,
            color: Colors.brown,
          ),
          backgroundColor: Colors.amber,
        ),
        title: Text('10/12/2019'),
        subtitle: Text('Quantidade: 3212'),
        onTap: () {},
        trailing: Icon(FontAwesomeIcons.undo),
      ),
    );
  }

  Widget buildCardSection() {
    return Container(
      width: 300.0,
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.bars,
                    size: 50.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Histórico de compras",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardWaiting() {
    return Container(
      width: 300.0,
      child: Card(
        child: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 10.0,
            // ),
            // Icon(
            //   FontAwesomeIcons.history,
            //   size: 50.0,
            // ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Text(
            //   "Acompanhe o status do seu pedido",
            //   style: TextStyle(
            //     fontSize: 20.0,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // Divider(
            //   color: Colors.brown,
            //   height: 20.0,
            // ),
            // Text(
            //     "Status: ${order?.orderAproved == null ? 'pedido não autorizado' : order.orderAproved ? 'pedido realizado' : 'pedido não realizado'}"),
            // SizedBox(
            //   height: 10.0,
            // ),
          ],
        ),
      ),
    );
  }
}
