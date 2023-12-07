import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/user_data_apis.dart';
import '../../widgets/error_pop_up.dart';

class OTPController extends GetxController {
  Timer? _countdownTimer;
  RxInt initialCountdownSeconds = 0.obs; // 1 minute and 30 seconds
  final _api = UserDataApis();

  void startTimer() {
    if (_countdownTimer != null) {
      _countdownTimer!.cancel();
    }
    initialCountdownSeconds.value = 60;
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (initialCountdownSeconds.value > 0) {
        initialCountdownSeconds.value--;
      } else {
        _countdownTimer!.cancel();
      }
    });
  }


  sendOtp({required String phone}) async {
    startTimer();
    try {
      await _api.sendVerificationCodeRequest(phone: phone);
    } on DioException catch (e, s) {
      ErrorPopUp(message: e.toString(), title: tr('Error'));
    } catch (e) {
      ErrorPopUp(message: e.toString(), title: tr('Error'));
    }
  }

  String? phone;
  updatePhone({required String phone}) {
    this.phone = phone;
    sendOtp(phone: phone);
  }

  checkTheOtp({required String sms}) async {
    await _api.checkCodeRequest(phone: phone ?? '', sms: sms);
  }

  Future<void> updatePassword({required String phone, required String password, required String rePassword}) async {
    try{
      await _api.forgetPasswordRequest(phone:phone, password:password, rePassword:rePassword);
      ErrorPopUp(
          message: tr('update_success'), title: tr('message'), isError: false);
    } on DioError catch (e, s) {

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');

    } catch (e, s) {
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');

    }
  }

}
