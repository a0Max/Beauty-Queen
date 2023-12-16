import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/events_data_apis.dart';
import '../../const/vars.dart';
import '../../models/departments_model.dart';
import '../../widgets/error_pop_up.dart';

class EventsController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxList eventsList = [].obs;
  var event = DepartmentsModel().obs;


  final _api = EventsDataApis();
  getEvents() async {
    isLoading.value = true;
    try {
      eventsList.value = await _api.getEventDataRequest();
    }on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }
  RxList listOfImage = [].obs;

  currentGetEvents({required String id}) async {
    isLoading2.value = true;
    try {
      event.value = await _api.getDetailsEventDataRequest(eventId: id);
      updateCurrentImage(newCurrentImage: Connection.urlOfEvent(image: event.value.mainImage?.file??''));
      listOfImage.value = event.value.images?.map((obj) => Connection.urlOfEvent(image:obj.file??'')).toList()??[];
      // listOfImage.add(element);
      print('listOfImage:${listOfImage.length}');
    }on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading2.value = false;
  }

  RxString currentImage = ''.obs;
  updateCurrentImage({required String newCurrentImage}){
    currentImage.value = newCurrentImage;
  }
}