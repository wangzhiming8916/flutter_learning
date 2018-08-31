import 'package:flutter/material.dart';

import 'view/view.dart' show ListTileCell;
import '00_base_page.dart';

class ShoppingListPage extends BasePage {
  ShoppingListPage({Key key, String title}) : super(key: key, title: title);

  final List<Product> products = <Product>[
    Product(name: 'Eggs'),
    Product(name: 'Flour'),
    Product(name: 'Chocolate chips'),
    Product(name: 'Apple'),
    Product(name: 'Orange'),
  ];

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends BasePageState<ShoppingListPage> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: widget.products.map((product) {
          return ProductListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

// =============================================================================

typedef CartChangedCallback(Product product, bool inCart);

class ProductListItem extends StatelessWidget {
  ProductListItem({
    @required this.product,
    @required this.inCart,
    @required this.onCartChanged
  }) : assert(product != null),
        assert(inCart != null),
        assert(onCartChanged != null);

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getBackgroundColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    return !inCart ? null : TextStyle(
      color: Colors.black45,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTileCell(
      onTap: () => onCartChanged(product, !inCart),
      leading: CircleAvatar(
        backgroundColor: _getBackgroundColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class Product {
  const Product({@required this.name}) : assert(name != null);
  final String name;
}