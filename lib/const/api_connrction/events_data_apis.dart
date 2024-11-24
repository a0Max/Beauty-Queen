import 'package:dio/dio.dart';

import '../../models/departments_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class EventsDataApis extends ApiProvider {

  Future<List<DepartmentsModel>> getEventDataRequest() async {
    final token = await getUserToken();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getEventsDataEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      final List<DepartmentsModel> l = [];
      response.data['events'].forEach((e) => l.add(DepartmentsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }


  Future<DepartmentsModel> getDetailsEventDataRequest({required String eventId}) async {
    final token = await getUserToken();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getEventDataEndPoint}/$eventId',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      return  DepartmentsModel.fromJson(response.data['event']);
    } else {
      throw response.data;
    }
  }

}