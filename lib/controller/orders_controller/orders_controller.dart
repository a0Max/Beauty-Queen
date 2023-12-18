import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/order_data_apis.dart';
import '../../models/order_model.dart';
import '../../widgets/error_pop_up.dart';

class OrdersController extends GetxController{
  RxBool loadingOrders = false.obs;
  RxList listOfOrders = [].obs;
  final _api = OrderDataApis();
  getOrders() async {
    loadingOrders.value = true;

    try {
      listOfOrders.value = await _api.getOrdersDataRequest();
    }on DioException catch (e) {
      print('error:getOrders:$e');
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      print('error:getOrders:$e');
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    loadingOrders.value = false;

  }

  RxBool loadingDetailsOrders = false.obs;
  var order = OrderModel().obs;
  getDetailsOfOrder({required String id}) async {
    loadingDetailsOrders.value = true;
    order.value = OrderModel();
    try {
      order.value = await _api.getDetailsOrdersDataRequest(orderId: id);
    }on DioException catch (e) {
      print('error:getOrders:$e');
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      print('error:getOrders:$e');
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    loadingDetailsOrders.value = false;
  }
}