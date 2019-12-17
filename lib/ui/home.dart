import 'package:brow/model/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:brow/ui/cart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  final Order order;

  Home({Key key, this.order}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(order);
}

class _HomeState extends State<Home> {
  Order order;

  _HomeState(this.order);

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logar();
  }

  void logar() {
    _googleSignIn.signIn().then((data) {
      print('Usuário ${data.displayName} autenticado!');
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
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
            Icon(
              FontAwesomeIcons.bars,
              size: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Histórico de compras",
              style: TextStyle(
                fontSize: 20.0,
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
            SizedBox(
              height: 10.0,
            ),
            Icon(
              FontAwesomeIcons.history,
              size: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Acompanhe o status do seu pedido",
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: Colors.brown,
              height: 20.0,
            ),
            Text(
                "Status: ${order?.orderAproved == null ? 'pedido não autorizado' : order.orderAproved ? 'pedido realizado' : 'pedido não realizado'}"),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
