import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../models/transactions_model.dart';
import '../../widgets/based/error_pop_up.dart';

class WalletController extends GetxController {
  final _api = AppDataApis();
  RxString walletAmountState = ''.obs;
  RxBool loadingWallet = false.obs;
  getAllWallet() async {
    try {
      loadingWallet.value = true;

      // walletList.value = await _api.getWalletTransactionsataRequest();
      List<TransactionsModel> walletData =
          await _api.getWalletTransactionsDataRequest();
      calculateTheTotalOfWallet(walletData: walletData);
    } on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    loadingWallet.value = false;
  }

  checkGiftCard({required String code}) async {
    await _api.checkGiftCardTransactionsDataRequest(code: code);
  }

  calculateTheTotalOfWallet({required List<TransactionsModel> walletData}) {
    double total = 0.0;

    ///todo: calculate all wallet states
    for (TransactionsModel wallet in walletData) {
      if (wallet.type == WalletState.add) {
        total = total + num.parse("${wallet.amount}");
      }
    }
    walletAmountState.value = "$total";
  }
}
