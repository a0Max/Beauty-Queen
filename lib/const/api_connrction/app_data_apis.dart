import 'package:beauty_queen/const/vars.dart';
import 'package:beauty_queen/models/notification_model.dart';
import 'package:dio/dio.dart';
import '../../models/departments_model.dart';
import '../../models/faq_model.dart';
import '../../models/transactions_model.dart';
import 'base_api_connection.dart';

class AppDataApis extends ApiProvider {
  Future<List<NotificationModel>> getNotificationsDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getNotificationsDataEndPoint}',
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
      makeNotificationsReadDataRequest();
      final List<NotificationModel> l = [];
      response.data['notifications']
          .forEach((e) => l.add(NotificationModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<void> makeNotificationsReadDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();

    await dio.get(
      '${Connection.apiURL}${ApiProvider.readNotificationsDataEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
  }

  Future<List<DepartmentsModel>> getAboutMEDataRequest() async {
    final token = await getUserToken();
    final checkNetwork = await getCheckNetwork();
    final cookies = await getCookies();

    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getAboutTheStoreDataEndPoint}',
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
      final List<DepartmentsModel> l = [];
      response.data['departments']
          .forEach((e) => l.add(DepartmentsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<bool> sendMessageRequest(
      {required String phone, required String message}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.sendMessageDataEndPoint}',
      queryParameters: {'phone': phone, 'message': message},
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
      return true;
    } else {
      throw response.data;
    }
  }

  Future<List<TransactionsModel>> getTransactionsataRequest() async {
    final token = await getUserToken();
    final checkNetwork = await getCheckNetwork();
    final cookies = await getCookies();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getQueenaTransactionsDataEndPoint}',
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
      final List<TransactionsModel> l = [];
      response.data['transactions']
          .forEach((e) => l.add(TransactionsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<List<TransactionsModel>> getWalletTransactionsDataRequest() async {
    final token = await getUserToken();
    final checkNetwork = await getCheckNetwork();
    final cookies = await getCookies();

    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getWalletTransactionsDataEndPoint}',
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
      final List<TransactionsModel> l = [];
      response.data['transactions']
          .forEach((e) => l.add(TransactionsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future checkGiftCardTransactionsDataRequest({required String code}) async {
    final token = await getUserToken();
    final checkNetwork = await getCheckNetwork();
    final cookies = await getCookies();

    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.checkGiftCardCodeDataEndPoint}',
      queryParameters: {'code': code},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
    } else {
      throw response.data;
    }
  }

  Future<List<FAQModel>> getFAQDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getFAQDataEndPoint}',
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
      final List<FAQModel> l = [];
      response.data['questions'].forEach((e) => l.add(FAQModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }
}
