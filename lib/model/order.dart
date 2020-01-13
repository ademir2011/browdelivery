import 'package:flutter/material.dart';

class Order {
  int id;
  String location;
  int amountBrownie;
  bool orderAproved;
  TimeOfDay tod;

  Order({this.location, this.amountBrownie, this.orderAproved, this.tod});

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'amountBrownie': amountBrownie,
      'orderAproved': orderAproved,
    };
  }
}
