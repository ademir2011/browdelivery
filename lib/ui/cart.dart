import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String defaultValue = "1";
  TimeOfDay horarioChegada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text("Quantidade"),
                  trailing: DropdownButton(
                    value: defaultValue,
                    onChanged: (String newValue) {
                      setState(() {
                        defaultValue = newValue;
                      });
                    },
                    items: ["1", "2", "3", "4"].map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Local da entrega',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(horarioChegada == null
                        ? 'Hora de chegada'
                        : "${horarioChegada.hour}:${horarioChegada.minute}"),
                    onPressed: () async {
                      TimeOfDay tod = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      setState(() {
                        horarioChegada = tod;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            child: Text('Solicitar'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
