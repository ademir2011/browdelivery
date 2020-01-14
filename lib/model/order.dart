import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  int id;
  String location;
  int amountBrownie;
  String orderStatus;
  DateTime todDateTime;
  String tod;
  String userName;

  Order(
      {this.location,
      this.amountBrownie,
      this.orderStatus,
      this.tod,
      this.userName});

  Order.fromMap(Map map) {
    this.id = map['id'];
    this.location = map['location'];
    this.amountBrownie = map['amountBrownie'];
    this.orderStatus = map['orderStatus'];
    this.tod = map['tod'];
    this.todDateTime = DateTime.parse(map['tod']);
    this.userName = map['userName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'amountBrownie': amountBrownie,
      'orderStatus': orderStatus,
      'tod': tod,
      'userName': userName,
    };
  }

  Timestamp getTodTimeStamp() => Timestamp.fromDate(todDateTime);
}
