import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  int id;
  String location;
  int amountBrownie;
  String orderStatus;
  Timestamp tod;
  String userName;

  Order(
      {this.location,
      this.amountBrownie,
      this.orderStatus,
      this.tod,
      this.userName});

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'amountBrownie': amountBrownie,
      'orderStatus': orderStatus,
      'tod': tod,
      'userName': userName,
    };
  }
}
