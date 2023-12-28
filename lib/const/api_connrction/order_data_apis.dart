import 'package:dio/dio.dart';

import '../../models/order_details_model.dart';
import '../../models/order_model.dart';
import '../../models/sub_models.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class OrderDataApis extends ApiProvider {
  Future<List<OrderDetailsModel>> getOrdersDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
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
      response.data['orders']
          .forEach((e) => l.add(OrderDetailsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<OrderModel> getDetailsOrdersDataRequest(
      {required String orderId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
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

  Future<SubModels> getDataDetails() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getCartDetailsDataEndPoint}',
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
      return SubModels.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<SubModels> updateShippingCostDetails({required String areaId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.updateShippingCostDataEndPoint}/$areaId',
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
      return SubModels.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<SubModels> getAreaDataRequest({required int cityId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getAreasDataEndPoint}/$cityId',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      return SubModels.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<void> confirmOrderDataRequest({required String orderId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.confirmOrderDataEndPoint}',
      queryParameters: {'id': orderId},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
    } else {
      throw response.data;
    }
  }

  Future<void> cancelOrderDataRequest({required String orderId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.cancelOrderDataEndPoint}',
      queryParameters: {'id': orderId},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
    } else {
      throw response.data;
    }
  }

  Future<SubModels> getOrderIdRequest(
      {required String address,
      required String? area,
      required String city,
      required String email,
      required String name,
      required bool saveData,
      required String? note,
      required String type,
      required String? phone,
      required String paymentMethod}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio
        .post('${Connection.apiURL}${ApiProvider.storeCartDataEndPoint}',
            options: Options(
              headers: {
                ...apiHeaders,
                'Accept-Language': await ApiProvider.getAppLanguage(),
                if (cookies != null) "Cookie": '$cookies',
                if (token != null) "Authorization": 'Bearer $token',
              },
            ),
            data: {
          'address': address,
          'area': area,
          'city': city,
          'email': email,
          'name': name,
          'notes': note,
          'payment_method': paymentMethod,
          'phone': phone,
          'saveData': saveData,
          'type': type
        });

    if (validResponse(response.statusCode!)) {
      return SubModels.fromJson(response.data);
    } else {
      throw response.data;
    }
  }
}
