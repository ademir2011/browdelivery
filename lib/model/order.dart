import 'package:flutter/material.dart';

class Order {
  String location;
  int amountBrownie;
  bool orderAproved;
  TimeOfDay tod;

  Order({this.location, this.amountBrownie, this.orderAproved, this.tod});
}
