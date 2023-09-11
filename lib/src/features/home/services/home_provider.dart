import 'package:flutter/foundation.dart';
import '../../../common/product_model.dart';
import '../../../constants/mockup_products.dart';

//List initData = MockData.productItems['product_items']!.cast<ProductModel>();

// List<ProductModel> initData =
//     MockData.productItems['product_items']!.cast<ProductModel>();
List<ProductModel> initData = MockData.productItems['product_items']!
    .map((e) => ProductModel.fromJson(e))
    .toList();

class HomeProvider with ChangeNotifier {
  final List<ProductModel> _homeItems = initData;
  List<ProductModel> get homeItems => _homeItems;

  final List<ProductModel> _savedItems = [];
  List<ProductModel> get savedItems => _savedItems;

  final List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => _cartItems;

  double _sumPrice = 0;
  double get sumPrice {
    _sumPrice = 0;
    for (var e in _cartItems) {
      _sumPrice = _sumPrice + (e.number ?? 0) * (e.price ?? 0);
    }
    return _sumPrice;
  }

  void addToSaved(ProductModel product) {
    _savedItems.add(product);
    notifyListeners();
  }

  void removeFromSaved(ProductModel product) {
    _savedItems.remove(product);
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    final foundProduct =
        _cartItems.where((element) => element.id == product.id);

    if (foundProduct.isNotEmpty) {
      foundProduct.first.number = (foundProduct.first.number ?? 0) + 1;
    } else {
      product.number = 1;
      _cartItems.add(product);
    }
    
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    final foundProduct =
        _cartItems.where((element) => element.id == product.id);
    int number = foundProduct.first.number ?? 0;
    if (foundProduct.isNotEmpty && number > 1) {
      foundProduct.first.number = number - 1;
    }

    notifyListeners();
  }

  void removeAllFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
