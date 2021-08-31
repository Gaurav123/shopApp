import 'dart:convert';

import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;

class OrderItem{
  final String? id;
  final double? amount;
  final List<CartItem>? product;
  final DateTime? dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.product,
    this.dateTime,
});
}

class Order with ChangeNotifier{
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;
  Order(this.authToken,this.userId,this._orders);

  List<OrderItem>? get orders{
    return [..._orders];
  }
  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://fir-app-23473-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          product: (orderData['products'] as List<dynamic>)
              .map(
                (item) =>
                CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
          )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

    Future<void> addOrder(List<CartItem> cartProduct, double tota) async {
      final url = Uri.parse(
          'https://fir-app-23473-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
      final timestamp = DateTime.now();
      final response = await http.post(url, body: json.encode({
        'amount': tota,
        'date': timestamp.toIso8601String(),
        'product': cartProduct.map((cp) =>
        {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price
        }).toList()
      }),);
      _orders.insert(0, OrderItem(
          id: json.decode(response.body)['name'],
          amount: tota,
          dateTime: timestamp,
          product: cartProduct));
      notifyListeners();
    }
  }