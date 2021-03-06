import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/order.dart' show Order;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_items.dart';

class OrdersScreen extends StatelessWidget {
 static const routeName = '/orders';

 var _isLoading = false;

  @override
  Widget build(BuildContext context) {
   //final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body:FutureBuilder(future: Provider.of<Order>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx,dataSnapshot) {
      if(dataSnapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }else{
        if(dataSnapshot.error == null){
          //
          return Center(child: Text('Eroro Accured'),);
        }
        else{
          return Consumer<Order>(
            builder: (ctx,orderData,child) =>
          ListView.builder(
              itemCount: orderData.orders!.length,
              itemBuilder: (ctx ,i) =>
                  OrderItem(orderData.orders![i])));
        }
      }
            }

        ,)
    );
  }
}
