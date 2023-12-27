// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/api_connrction/order_data_apis.dart';
import '../const/api_connrction/user_data_apis.dart';
import '../models/city_area_model.dart';
import '../models/order_model.dart';
import '../models/sub_models.dart';
import '../widgets/based/error_pop_up.dart';
import 'auth_controller/auth_controler.dart';

class BasketController extends GetxController {
  final RxBool isLineVisible = false.obs;
  Color containerColor = Colors.white;

  RxBool isSelected = true.obs;
  var selectedValue = ''.obs;
  var selectedValue2 = ''.obs;
  var selectedValue3 = ''.obs;
  final List<String> dropdownItems = [
    'طرابلس'
        'عين زارة'
        'بجانب مول طرابلس للتسوق'
  ];

  // Create an observable variable to track the radio button state

  void updateSelection(bool value) {
    isSelected.value = value;
  }

  var selectedPaymentMethod = 'cash'.obs;

  void selectPaymentMethod(String value) {
    selectedPaymentMethod.value = value;
  }

  void showLine() {
    isLineVisible.value = true;
  }

  //////////////////////////////////////////////////////////////
  // final _api = UserDataApis();
  final _api2 = OrderDataApis();

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
  }

  var order = OrderModel().obs;

  sendToCreateOrder({required String email, required String name}) async {
    try {
      print("address:${finalAddress.value}");
      print("area:${selectedAreaData.value.id.toString()}");
      print("city:${selectedCityData.value.id.toString()}");
      print("name:${name}");
      print("saveData:${isChecked.value}");
      print("notes:${finalNote.value}");
      print("phone:${finalPhone.value}");
      print("type:${selectedPaymentMethod2.value}");
      print("payment_method:${selectedPaymentMethod.value}");
      print("email:${email}");
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
    } catch (e) {
      print('error:getOrders:$e');
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
  }
}
