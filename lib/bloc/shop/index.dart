import 'package:flutter/material.dart';
import 'package:hope_clinic/model/market-shop.dart';

class ShopBloc extends ChangeNotifier {
  List<MarketShop> _marketShop;
  List<MarketShop> get marketShop {
    return _marketShop;
  }

  set marketShop(List<MarketShop> _data) {
    this._marketShop = _data;
    notifyListeners();
  }
  ///fetch reviews
  Future<List<Reviews>> fetchReviews(BuildContext context, String id) async {
    ReviewsService reviewsService = new  ReviewsService(
        context: context);
    List<Reviews> _reviews = await reviewsService.getReviews(id);
    this._reviews = _reviews;
    notifyListeners();
    return _reviews;
  }

}
