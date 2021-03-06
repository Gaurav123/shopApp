import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/helpers/custome_route.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/order.dart';
import 'package:shopapp/screens/auth_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/user_product_screen.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/user_product_screen.dart';
import 'screens/splash__screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth(),),
        ChangeNotifierProxyProvider<Auth ,Products>(
          create: (ctx) => Products('', '' , []),
          update:(ctx,auth, previousProducts) => Products(

              auth.token,auth.userId,previousProducts == null ? [] : previousProducts.items! ),

        ),

        ChangeNotifierProvider(
          create:(ctx) => Cart(),
        ),
    ChangeNotifierProxyProvider<Auth,Order>(
        create: (ctx)=>Order('','' , []),
        update: (ctx,auth,previousProducts) => Order(
            auth.token,auth.userId,previousProducts == null ? [] : previousProducts.orders!),


    )],
      child:  Consumer<Auth>(builder: (ctx,auth,_) =>MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS:CustomPageTransitionBuilder(),
              }
            )
          ),
          home: auth.isAuth! ? ProductsOverviewScreen() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx,authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
            ? SplashScreen()
          :AuthScreen(),),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName:  (ctx) => EditProductScreen(),
          })
      ));

  }

}
