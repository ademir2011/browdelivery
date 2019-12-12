import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:brow/ui/cart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: buildListView(),
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
}
