import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/services/index.dart';
import 'package:provider/provider.dart';

class  MarketService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  MarketService({@required this.context}) : super(context: context);

  /// get market shop
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
  /// get reserved products
  Future<List<ReservedItem>> getReservedProducts() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('reserve');
    print(_data);
    List<ReservedItem> _reservedItem = [];
    _reservedItem = ReservedItem.fromJsonList(_data['data']['reserves']['data']);
    bloc.reservedProducts= _reservedItem;
    return _reservedItem;
  }
  /// delete reserved item
  Future<Map<String, dynamic>> reserveProduct(Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('reserve/add', data);

    return _response;
  }
  /// reserve product
  Future<Map<String, dynamic>> deleteReservedItem(Map<String, dynamic> data, String reserveId) async {
    Map<String, dynamic> _response = await post('reserve/delete/${reserveId}', data);

    return _response;
  }
}