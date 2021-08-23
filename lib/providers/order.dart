import 'package:flutter/foundation.dart';
import './cart.dart';

class OderItem{
  final String? id;
  final double? amount;
  final List<CartItem>? product;
  final DateTime? dateTime;

  OderItem({
    required this.id,
    required this.amount,
    required this.product,
    this.dateTime,
});
}

class Order with ChangeNotifier{
  List<OderItem> _orders = [];

  List<OderItem> get orders{
    return [..._orders];
  }
  void addOrder(List<CartItem> cartProduct ,double tota){
    _orders.insert(0, OderItem(
        id: DateTime.now().toString(),
    amount: tota,dateTime: DateTime.now(),
        product: cartProduct));
    notifyListeners();
  }
}