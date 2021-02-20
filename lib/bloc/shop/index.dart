import 'package:flutter/material.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/screens/shop/reserved-products.dart';
import 'package:hope_clinic/services/shop/index.dart';

class ShopBloc extends ChangeNotifier {
  List<MarketShop> _marketShop;
  List<MarketShop> get marketShop {
    return _marketShop;
  }

  set marketShop(List<MarketShop> _data) {
    this._marketShop = _data;
    notifyListeners();
  }
  List<ReservedProducts> _reservedProducts;
  List<MarketShop> get marketShop {
    return _marketShop;
  }

  set marketShop(List<MarketShop> _data) {
    this._marketShop = _data;
    notifyListeners();
  }
  ///fetch market shop
  Future<List<MarketShop>> fetchMarketShop(BuildContext context) async {
    MarketService marketService = new  MarketService(
        context: context);
    List<MarketShop> _marketShop = await marketService.getMarketShop();
    this._marketShop = _marketShop;
    notifyListeners();
    return _marketShop;
  }
  Future<List<ReservedProducts>> fetchReservedProducts(BuildContext context) async {
    MarketService marketService = new  MarketService(
        context: context);
    List<ReservedProducts> _reservedProducts = await marketService.getMarketShop();
    this._marketShop = _marketShop;
    notifyListeners();
    return _marketShop;
  }
}
