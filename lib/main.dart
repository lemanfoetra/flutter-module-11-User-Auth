import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/product_provider.dart';
import './providers/chart_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: null,
          update: (ctx, authObj, productObj) => ProductsProvider(authObj.idToken),
        ),
        ChangeNotifierProvider.value(
          value: ChartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: null,
          update: (ctx, authObj, ordersObj) => OrdersProvider(authObj.idToken),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Lato',
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => auth.isAuth ? ProductOverviewScreeen() : AuthScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreeen.routeName: (ctx) => OrdersScreeen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
          onUnknownRoute: (setting) {
            return MaterialPageRoute(
              builder: (ctx) => ProductOverviewScreeen(),
            );
          },
        ),
      ),
    );
  }
}
