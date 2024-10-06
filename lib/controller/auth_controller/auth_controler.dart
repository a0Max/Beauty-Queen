import 'dart:developer';

import 'package:beauty_queen/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/auth_view/login_page.dart';
import '../../View/auth_view/otp_page_view.dart';
import '../../View/home/bottom_nav_screen.dart';
import '../../View/welcome/welcome_screen.dart';
import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/user_data_apis.dart';
import '../../const/notification.dart';
import '../../models/brand_model.dart';
import '../../models/city_area_model.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';

import 'package:uni_links/uni_links.dart' as uniLinks;
import '../../const/unilink_client.dart';
import 'package:quiver/strings.dart';

class AuthController extends GetxController {
  var obscureText = true.obs;
  var userData = UserModel().obs;
  final _api = UserDataApis();
  final _api2 = BrandsDataApis();

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  login(String phone, String password) async {
    userData.value = await _api.loginRequest(phone: phone, password: password);
    await getUserData();
    getCities();
  }

  var passwordObscureText = true.obs;
  var confirmPasswordObscureText = true.obs;

  void toggleSignUpPasswordVisibility() {
    passwordObscureText.value = !passwordObscureText.value;
  }

  void toggleSignUpConfirmPasswordVisibility() {
    confirmPasswordObscureText.value = !confirmPasswordObscureText.value;
  }

  Future<void> signUp(
      {required String phone,
      required String password,
      required String name,
      required String rePassword}) async {
    userData.value =
        await _api.signUpRequest(phone: phone, password: password, name: name);
    getUserData();
  }

  Future<bool?> _initUniLinks() async {
    bool? linkState;
    try {
      await Future.delayed(const Duration(seconds: 1), () {});
      String? initialLink = await uniLinks.getInitialLink();
      if (isNotBlank(initialLink)) {
        debugPrint('initialLink $initialLink');
        linkState = await UniLinkClient.launchAd(initialLink!);
      } else {
        Uri? initialUri = await uniLinks.getInitialUri();
        if (initialUri != null) {
          debugPrint('initialLink $initialLink');
          linkState = await UniLinkClient.launchAd(initialUri.toString());
        }
      }
    } on PlatformException catch (e, s) {
      print('Manuel Reporting Crash $e - $s');
    }

    uniLinks.linkStream.listen((String? link) async {
      if (isNotBlank(link)) {
        debugPrint(link);
        linkState = await UniLinkClient.launchAd(link!);
      } else {
        uniLinks.uriLinkStream.listen((link) async {
          linkState = await UniLinkClient.launchAd(link.toString());
        }, onError: (e, s) {
          print('Manuel Reporting Crash $e - $s');
        });
      }
    }, onError: (e, s) {
      print('Manuel Reporting Crash $e - $s');
    });
    return linkState;
  }

  var progressValue = 0.0.obs;
  var showProgress = true.obs;

  void startProgress() async {
    while (progressValue.value < 1.0) {
      await Future.delayed(const Duration(milliseconds: 25));
      progressValue.value += 0.01;
      if (progressValue.value == 0.01) {
        try {
          await getUserData();
        } catch (e, s) {
          // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
          log('startProgress:Error:$e');
        }
      }
    }
    showProgress.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
    bool? linkState = await _initUniLinks();
    if (linkState == true) {
      return;
    }
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        NotificationHelper().handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationHelper().handleMessage(message);
    });
    if (userData.value.id != null) {
      Get.off(() => const MainView());
    } else {
      Get.off(() => const WelcomeScreen());
    }
  }

  getUserData() async {
    userData.value = await _api.userDataRequest();
    await NotificationHelper().onTokenRefresh();
  }

  logoutUserData() async {
    _api.logoutUserRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userData.value = UserModel();
  }

  deleteUserData() async {
    _api.deleteUserRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userData.value = UserModel();
  }

  RxString dateTime = ''.obs;
  updateDateTime({required String newDateTime}) {
    dateTime.value = newDateTime;
  }

  var selectedCityData = CityAreaModel().obs;
  RxList citiesData = [].obs;
  RxList areaData = [].obs;

  var selectedAreaData = CityAreaModel().obs;

  getCities() async {
    citiesData.value = await _api.getCityDataRequest();
  }

  RxBool loadingArea = false.obs;
  updateSelectedCity({required CityAreaModel newCity}) async {
    selectedCityData.value = newCity;
    selectedAreaData.value = CityAreaModel();
    if (newCity.hasArea == '1') {
      loadingArea.value = true;
      await getArea(cityId: newCity.id ?? 0);
      loadingArea.value = false;
    }
  }

  updateSelectedArea({required CityAreaModel newArea}) {
    selectedAreaData.value = newArea;
  }

  getArea({required int cityId}) async {
    areaData.value = await _api.getAreaDataRequest(cityId: cityId);
  }

  RxBool allowToEdit = false.obs;
  applyToEdit() {
    print("${allowToEdit.value}");
    allowToEdit.value = !(allowToEdit.value);
    print("${allowToEdit.value}");
  }

  applyToSaveEdit(
      {required String nameController,
      required String nickNameController,
      required String phoneController,
      required String whatsAppController,
      required String phoneController2,
      required String emailController}) async {
    await _api.updateUserRequest(
      name: nameController,
      lastName: nickNameController,
      birthDate: dateTime.value,
      phone: phoneController,
      cityId: "${selectedCityData.value.id}",
      areaId: "${selectedAreaData.value.id}",
      phone2: phoneController2,
      email: emailController,
      whatsappPhone: whatsAppController,
      brand1: "${selectedBrandData1.value.id}",
      brand2: "${selectedBrandData2.value.id}",
      brand3: "${selectedBrandData3.value.id}",
    );
    getUserData();
  }

  applyToChangePassword(
      {required String currentPassword,
      required String newPassword,
      required String reNewPassword}) async {
    await _api.updatePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
        reNewPassword: reNewPassword);
  }

  RxList brandsData = [].obs;
  RxBool loadingBrands = false.obs;

  Future<void> getBrandsDataController() async {
    try {
      loadingBrands.value = true;
      brandsData.value = await _api2.breandsDataRequest();
    } on DioException catch (e) {
      brandsData.value = [];
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      brandsData.value = [];
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    loadingBrands.value = false;
  }

  var selectedBrandData1 = BrandModel().obs;
  updateSelectedBrand1({required BrandModel newBrand}) async {
    selectedBrandData1.value = newBrand;
  }

  var selectedBrandData2 = BrandModel().obs;
  updateSelectedBrand2({required BrandModel newBrand}) async {
    selectedBrandData2.value = newBrand;
  }

  var selectedBrandData3 = BrandModel().obs;
  updateSelectedBrand3({required BrandModel newBrand}) async {
    selectedBrandData3.value = newBrand;
  }

  clearBrand() {
    brandsData.value = [];
    selectedBrandData3.value = BrandModel();
    selectedBrandData2.value = BrandModel();
    selectedBrandData1.value = BrandModel();
    allowToEdit.value = false;
  }

  googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // print('googleAuth?.accessToken:${googleUser?.email}');
      // print('googleAuth?.accessToken:${googleUser?.id}');
      // print('googleAuth?.accessToken:${googleUser?.displayName}');
      // print('googleAuth?.accessToken:${googleUser?.photoUrl}');
      // print('googleAuth?.accessToken:${googleUser?.serverAuthCode}');
      // print('googleAuth?.accessToken:${googleAuth?.accessToken}');
      await googleLoginData(
          googleId: googleAuth?.accessToken ?? '',
          email: googleUser?.email ?? '',
          name: googleUser?.displayName ?? '');
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      print('errir:$e');
      print('errir:${e.runtimeType}');
    }
  }

  upgradeAccount() async {
    await _api.upgradeUserStateRequest();
    await getUserData();
  }

  googleLoginData(
      {required String googleId,
      required String email,
      required String name}) async {
    var context = Get.context;

    try {
      LoadingScreen.show(context!);
      userData.value = await _api.sendRequestOfGoogleLogin(
          googleId: googleId, email: email, name: name);
      getUserData();
      Get.back();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainView(),
          ),
          (route) => false);
    } on DioException catch (e) {
      Get.back();

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      Get.back();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  alertOfLogin() {
    var context = Get.context;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              buttonTwo: false,
              dilougText: tr('pleaseLogin'),
              buttonOneText: 'تسجيل الدخول',
              onButtonOnePressed: () {
                Get.off(const LogInPage());
              });
        });
  }

  RxBool checkSelectedBrandData1 = false.obs;
  RxBool checkSelectedBrandData2 = false.obs;
  RxBool checkSelectedBrandData3 = false.obs;
  RxBool checkSelectedCityData = false.obs;
  RxBool checkSelectedAreaData = false.obs;
  checkUpdateSelectedBrand1() async {
    print('checkUpdateSelectedBrand1:${(selectedBrandData1.value.id == null)}');
    if (selectedBrandData1.value.id == null) {
      checkSelectedBrandData1.value = true;
    } else {
      checkSelectedBrandData1.value = false;
    }
  }

  checkUpdateSelectedBrand2() async {
    if (selectedBrandData2.value.id == null) {
      checkSelectedBrandData2.value = true;
    } else {
      checkSelectedBrandData2.value = false;
    }
  }

  checkUpdateSelectedBrand3() async {
    if (selectedBrandData3.value.id == null) {
      checkSelectedBrandData3.value = true;
    } else {
      checkSelectedBrandData3.value = false;
    }
  }

  checkSelectedAreaDataAction() async {
    if (selectedAreaData.value.id == null) {
      checkSelectedAreaData.value = true;
    } else {
      checkSelectedAreaData.value = false;
    }
  }

  checkSelectedCityDataAction() async {
    if (selectedCityData.value.id == null) {
      checkSelectedCityData.value = true;
    } else {
      checkSelectedCityData.value = false;
      if (selectedCityData.value.hasArea != '1') {
        checkSelectedAreaData.value = false;
      }
    }
  }
}
