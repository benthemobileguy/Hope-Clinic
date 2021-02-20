import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/services/index.dart';
import 'package:provider/provider.dart';

class  MarketService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  MarketService({@required this.context}) : super(context: context);

  /// get reviews
  Future<List<MarketShop>> getMarketShop() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('store');
    print(_data);
    List<MarketShop> _marketShop = [];
    _marketShop = MarketShop.fromJsonList(_data['data']['store']['data']);
    bloc.marketShop = _marketShop;
    return _marketShop;
  }
  /// reserve product
  Future<Map<String, dynamic>> reserveProduct(Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('reserve/add', data);

    return _response;
  }
}