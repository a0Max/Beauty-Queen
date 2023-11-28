import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? birthDate;
  String? email;
  String? phone;
  String? address;
  String? cityId;
  String? areaId;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? balance;
  String? accountType;
  int? queenaBalance;
  String? upgradedToQueenaAt;
  String? brand1;
  String? brand2;
  String? brand3;
  String? phone2;
  String? whatsappPhone;


  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.emailVerifiedAt,
    this.address,
    this.accountType,
    this.areaId,
    this.balance,
    this.birthDate,
    this.brand1,
    this.brand2,
    this.brand3,
    this.cityId,
    this.lastName,
    this.phone2,
    this.queenaBalance,
    this.updatedAt,
    this.upgradedToQueenaAt,
    this.whatsappPhone
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json["user"]["id"];
    name = json["user"]["name"];
    lastName = json["user"]['last_name'];
    birthDate = json["user"]['birth_date'];
    email = json["user"]['email'];
    phone = json["user"]['phone'];
    address = json["user"]['address'];
    cityId = json["user"]['city_id'];
    areaId = json["user"]['area_id'];
    emailVerifiedAt = json["user"]['email_verified_at'];
    createdAt = json["user"]['created_at'];
    updatedAt = json["user"]['updated_at'];
    balance = json["user"]['balance'];
    accountType = json["user"]['account_type'];
    queenaBalance = json["user"]['queena_balance'];
    upgradedToQueenaAt = json["user"]['upgraded_to_queena_at'];
    brand1 = json["user"]['brand1'];
    brand2 = json["user"]['brand2'];
    brand3 = json["user"]['brand3'];
    phone2 = json["user"]['phone2'];
    whatsappPhone = json["user"]['whatsapp_phone'];
    if (isNotBlank(json["token"])) saveToken(json["token"]);
  }

  Map<String, dynamic> toMap() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
    };
  }

  static Future<String?> get getToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  static Future<bool> get isLoggedIn async => await getToken != null;

  static Future<void> saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token == null ? prefs.remove('token') : prefs.setString('token', token);
  }

}
