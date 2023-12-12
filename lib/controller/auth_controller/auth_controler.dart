import 'dart:developer';

import 'package:beauty_queen/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/home/bottom_nav_screen.dart';
import '../../View/welcome/welcome_screen.dart';
import '../../const/api_connrction/user_data_apis.dart';
import '../../models/city_area_model.dart';

class AuthController extends GetxController {
  var obscureText = true.obs;
  var userData = UserModel().obs;
  final _api = UserDataApis();

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  login(String phone, String password) async {
    userData.value = await _api.loginRequest(phone: phone, password: password);
    getUserData();
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

  var progressValue = 0.0.obs;
  var showProgress = true.obs;

  void startProgress() async {
    while (progressValue.value < 1.0) {
      await Future.delayed(const Duration(milliseconds: 25));
      progressValue.value += 0.01;
      if (progressValue.value == 0.01) {
        try {
          await getUserData();
        } catch (e) {
          log('Error:$e');
        }
      }
    }
    showProgress.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
    if (userData.value.id != null) {
      Get.off(() => const MainView());
    } else {
      Get.off(() => const WelcomeScreen());
    }
  }

  getUserData() async {
    userData.value = await _api.userDataRequest();
  }

  logoutUserData() async {
    _api.logoutUserRequest();
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

  updateSelectedCity({required CityAreaModel newCity}) {
    selectedCityData.value = newCity;
    selectedAreaData.value = CityAreaModel();
    if (newCity.hasArea == '1') {
      getArea(cityId: newCity.id ?? 0);
    }
  }
  updateSelectedArea({required CityAreaModel newArea}) {
    selectedAreaData.value = newArea;
  }

  getArea({required int cityId}) async {
    areaData.value = await _api.getAreaDataRequest(cityId: cityId);
  }

  RxBool allowToEdit = false.obs;
  applyToEdit(){
    allowToEdit.value = !(allowToEdit.value);
  }

  applyToSaveEdit(){

  }
}
