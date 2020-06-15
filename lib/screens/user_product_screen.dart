import 'package:flutter/material.dart';
import 'package:shop/widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  // Mengambil kembali data ketika halaman di refresh
  Future<void> _refreshHalaman(BuildContext context) async {
    var productData = Provider.of<ProductsProvider>(context);
    productData.bersihkanItems();
    await productData.getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawers(),
      body: RefreshIndicator(
        onRefresh: ()=> _refreshHalaman(context),
        child: Container(
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, i) {
              return UserProductItem(
                imgUrl: productData.items[i].imageUrl,
                productId: productData.items[i].id,
                title: productData.items[i].title,
              );
            },
          ),
        ),
      ),
    );
  }
}
