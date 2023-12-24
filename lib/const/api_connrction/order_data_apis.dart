import 'package:dio/dio.dart';

import '../../models/order_details_model.dart';
import '../../models/order_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class OrderDataApis extends ApiProvider {

  Future<List<OrderDetailsModel>> getOrdersDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false){
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getOrderHistoryDataEndPoint}',

      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      final List<OrderDetailsModel> l = [];
      response.data['orders'].forEach((e) => l.add(OrderDetailsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }


  Future<OrderModel> getDetailsOrdersDataRequest({required String orderId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false){
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getOrderDetailsDataEndPoint}/$orderId',

      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      return OrderModel.fromJson(
        response.data,
      );
    } else {
      throw response.data;
    }
  }
}