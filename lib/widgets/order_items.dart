import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text('\u{20B9}${widget.order.amount}'),
          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime!),),
          trailing: IconButton(
            icon: Icon(_expanded ?Icons.expand_less: Icons.expand_more),
            onPressed: (){
             setState(() {
               _expanded =!_expanded;
             });
            },
          ),
        ),
        if(_expanded)
          Container(
            height: min(
                widget.order.product!.length * 20.0 + 100,180),
          child: ListView(
            children: widget.order.product!
                .map(
                    (prod) =>
                Row(
                  children: <Widget>[
                    Text(
                      prod.title!,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${prod.quantity}x \u{20B9}${prod.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
            ).toList(),
          ),
          )

      ],
    ),);
  }
}