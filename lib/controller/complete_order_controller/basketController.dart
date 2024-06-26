// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/api_connrction/order_data_apis.dart';
import '../../const/api_connrction/user_data_apis.dart';
import '../../models/city_area_model.dart';
import '../../models/order_model.dart';
import '../../models/sub_models.dart';
import '../../widgets/based/error_pop_up.dart';
import '../auth_controller/auth_controler.dart';

class BasketController extends GetxController {
  Color containerColor = Colors.white;

  final _api2 = OrderDataApis();

  var selectedPaymentMethod = 'cash'.obs;

  void selectPaymentMethod(String value) {
    selectedPaymentMethod.value = value;
  }

  RxInt selectedIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  RxBool loadingArea = false.obs;
  var selectedCityData = CityAreaModel().obs;
  var selectedAreaData = CityAreaModel().obs;
  var areaData = SubModels().obs;
  var finalOrderData = SubModels().obs;

  updateSelectedCity({required CityAreaModel newCity}) async {
    selectedCityData.value = newCity;
    selectedAreaData.value = CityAreaModel();
    // if (newCity.hasArea == '1') {
    totalOrderDelivery.value = SubModels();

    loadingArea.value = true;
    await getArea(cityId: newCity.id ?? 0);
    loadingArea.value = false;

    // }else{
    //
    // }
  }

  getArea({required int cityId}) async {
    areaData.value = await _api2.getAreaDataRequest(cityId: cityId);
    if (areaData.value.shippingCost != null) {
      totalOrderDelivery.value = areaData.value;
    }
  }

  updateSelectedArea({required CityAreaModel newArea}) {
    selectedAreaData.value = newArea;
    getTotalOrderDelivery(areaId: selectedAreaData.value.id.toString());
  }

  RxBool isChecked = false.obs;
  updateChecked({required bool? newCheck}) {
    isChecked.value = newCheck ?? false;
  }

  var selectedPaymentMethod2 = '1'.obs;

  void selectPaymentMethod2(String value) {
    selectedPaymentMethod2.value = value;
  }

  var totalOrderDetails = SubModels().obs;
  var totalOrderDelivery = SubModels().obs;
  getTotalOrderDetails() async {
    totalOrderDetails.value = await _api2.getDataDetails();
  }

  getTotalOrderDelivery({required String areaId}) async {
    totalOrderDelivery.value =
        await _api2.updateShippingCostDetails(areaId: areaId);
  }

  RxString finalAddress = ''.obs;
  RxString finalNote = ''.obs;
  RxString finalPhone = ''.obs;

  addAddressTextAndNote(
      {required String address, required String phone, required String? note}) {
    finalAddress.value = address;
    finalPhone.value = phone;
    finalNote.value = note ?? '';
    print('isChecked.value:${isChecked.value}');
    if (isChecked.value == true) {
      saveTheOrderData(
          phone: phone,
          address: address,
          note: note ?? '',
          cityId: "${selectedCityData.value.id ?? ''}",
          areaId: "${selectedAreaData.value.id ?? ''}");
    } else {
      disapleToSaveOrderData();
    }
  }

  saveTheOrderData(
      {required String phone,
      required String address,
      required String note,
      required String cityId,
      required String? areaId}) async {
    print('saveTheOrderData');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
    prefs.setString('address', address);
    prefs.setString('note', note);
    prefs.setString('cityId', cityId);
    prefs.setString('areaId', areaId ?? '');
    prefs.setBool('saveDataOrder', true);
  }

  disapleToSaveOrderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('saveDataOrder', false);
  }

  var order = OrderModel().obs;

  sendToCreateOrder({required String email, required String name}) async {
    try {
      finalOrderData.value = await _api2.getOrderIdRequest(
          address: finalAddress.value,
          area: selectedAreaData.value.id.toString(),
          city: selectedCityData.value.id.toString(),
          name: name,
          saveData: isChecked.value,
          note: finalNote.value,
          phone: finalPhone.value,
          paymentMethod: selectedPaymentMethod.value,
          email: email,
          type: selectedPaymentMethod2.value);
      order.value = await _api2.getDetailsOrdersDataRequest(
          orderId: finalOrderData.value.orderID.toString());
    } on DioException catch (e) {
      print('error:getOrders:$e');
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      print('error:getOrders:$e');
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
  }

  completeOrder({required String orderId}) async {
    await _api2.confirmOrderDataRequest(orderId: orderId);
  }

  cancelOrder({required String orderId}) async {
    await _api2.cancelOrderDataRequest(orderId: orderId);
  }

  clearData() {
    selectedIndex = 0.obs;
  }
}
