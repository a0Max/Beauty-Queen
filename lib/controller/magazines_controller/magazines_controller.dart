import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:get/get.dart';

import '../../const/api_connrction/magazines_data_apis.dart';
import '../../models/magazines/main_magazines_model.dart';
import '../../widgets/based/error_pop_up.dart';
import 'package:video_player/video_player.dart';

class MagazinesController extends GetxController {
  final _api = MagazinesDataApis();
  var magazinesData = MainMagazinesModel().obs;
  late VideoPlayerController controller;
  RxBool isLoading = true.obs;

  Future<void> getMagazinesDataController() async {
    isLoading.value = true;
    try {
      magazinesData.value = await _api.getMagazinesDataRequest();
      controller = VideoPlayerController.networkUrl(Uri.parse(
          "${Connection.magazineVideoUrl + (magazinesData.value.info?.promoVideo?.file ?? '')}"));
      // ..initialize().then((_) {
      //   controller.setLooping(true);
      //   controller.play();
      // });
      controller.addListener(() {
        // Update your UI based on video playback status
        update();
      });
      controller.initialize().then((_) {
        controller.play();
        controller.setLooping(true);
      }).catchError((error) {
        print("Error occurred: $error");
      });
    } on DioException catch (e) {
      magazinesData.value = MainMagazinesModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      magazinesData.value = MainMagazinesModel();
      print('error:$e');
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }
}
