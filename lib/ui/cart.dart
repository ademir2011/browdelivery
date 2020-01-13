import 'package:brow/helpers/brow_database.dart';
import 'package:brow/model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String defaultValue = null;
  TimeOfDay horarioChegada;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Order order = Order();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Center(
        child: buildList(),
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

  Widget buildList() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                buildAmount(),
                SizedBox(
                  height: 20.0,
                ),
                buildPlace(),
                SizedBox(
                  height: 20.0,
                ),
                buildDate(),
              ],
            ),
            buildSubmit(),
          ],
        ),
      ),
    );
  }

  Widget buildAmount() {
    return DropdownButtonFormField(
      value: defaultValue ?? null,
      decoration: InputDecoration(labelText: "Quantidade de Brownie"),
      onChanged: (String newValue) {
        order.amountBrownie = int.parse(newValue);
        setState(() {
          defaultValue = newValue;
        });
      },
      items: ["0", "1", "2", "3", "4"].map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      validator: (value) => int.parse(value) < 1 ? 'Valo menor que 1' : null,
    );
  }

  Widget buildPlace() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Local da entrega',
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'Texto inválido!';
        else
          return null;
      },
      onChanged: (value) {
        order.location = value;
      },
    );
  }

  Widget buildDate() {
    return RaisedButton(
      child: Text(horarioChegada == null
          ? 'Hora de chegada'
          : "${horarioChegada.hour}:${horarioChegada.minute}"),
      onPressed: () async {
        TimeOfDay tod = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value == null)
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Hora não selecionada!'),
              ),
            );
          final now = DateTime.now();
          DateTime dt =
              DateTime(now.year, now.month, now.day, value.hour, value.minute);
          order.tod = Timestamp.fromDate(dt);
          return value;
        });

        setState(() {
          horarioChegada = tod;
        });
      },
    );
  }

  Widget buildSubmit() {
    return RaisedButton(
      child: Text('Solicitar'),
      onPressed: () {
        if (_formKey.currentState.validate() && horarioChegada != null) {
          BrowDatabase bd = BrowDatabase();

          bd.saveOrder(order);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Wait(
          //       order: order,
          //     ),
          //   ),
          // );

        }
      },
    );
  }
}
