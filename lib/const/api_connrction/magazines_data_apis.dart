import 'package:dio/dio.dart';

import '../../models/general_search_model.dart';
import '../../models/magazines/main_magazines_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';
import 'package:quiver/strings.dart';

class MagazinesDataApis extends ApiProvider {
  Future<MainMagazinesModel> getMagazinesDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getMagazinesDataEndPoint}',
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
      return MainMagazinesModel.fromJson(
        response.data,
      );
    } else {
      throw response.data;
    }
  }
}
